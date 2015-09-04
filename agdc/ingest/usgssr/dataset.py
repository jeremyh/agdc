# coding=utf-8
"""
Module
"""
from __future__ import absolute_import
from datetime import datetime
import logging

from osgeo import osr

from pathlib import Path
import yaml

from agdc.ingest.pretiled import SimpleDataset, PreTiledBandstack

_LOG = logging.getLogger(__name__)


def _get_extent(gt, cols, rows):
    """ Return the corner coordinates from a geotransform

    :param gt: geotransform (as given by gdal)
    :type gt: (float, float, float, float, float, float)
    :param cols: number of columns in the dataset
    :type cols: int
    :param rows: number of rows in the dataset
    :type rows: int
    :rtype: ptype.CoordPolygon

    >>> gt = (397000.0, 25.0, 0.0, 7236000.0, 0.0, -25.0)
    >>> cols = 9121
    >>> rows = 8881
    >>> _get_extent(gt, cols, rows)['ul'], _get_extent(gt, cols, rows)['ur']
    ((397000.0, 7236000.0), (625025.0, 7236000.0))
    >>> _get_extent(gt, cols, rows)['ll'], _get_extent(gt, cols, rows)['lr']
    ((397000.0, 7013975.0), (625025.0, 7013975.0))
    """

    def _get_point(gt, px, py):
        x = gt[0] + (px * gt[1]) + (py * gt[2])
        y = gt[3] + (px * gt[4]) + (py * gt[5])
        return x, y

    return {
        'ul': _get_point(gt, 0, 0),
        'll': _get_point(gt, 0, rows),
        'ur': _get_point(gt, cols, 0),
        'lr': _get_point(gt, cols, rows),
    }


def reproject_coords(coords, source_spatial_ref):
    """
    Reproject a list of x,y coordinates.

    :type coords:     ptype.PointPolygon
    :type source_spatial_ref:  C{osr.SpatialReference}
    :rtype:         ptype.CoordPolygon
    :return:        Projected coords

    """
    transform = osr.CoordinateTransformation(source_spatial_ref, source_spatial_ref.CloneGeogCS())

    def _reproject_point(p):
        x, y, height = transform.TransformPoint(p[0], p[1])
        return x, y

    return {k: _reproject_point(v) for k, v in coords.items()}


class LandsatUsgsSrDataset(SimpleDataset):
    """Dataset class for landsat ORTHO and NBAR datasets."""

    # We're forced to have many public methods due to the API.
    # pylint: disable=too-many-public-methods

    def __init__(self, dataset_path):
        """Opens the dataset and extracts metadata.

        Most of the metadata is kept in self._ds which is
        a eotools.drivers.SceneDataset object. Some extra metadata is
        extracted and kept the instance attributes.
        """
        self._dataset_path = Path(dataset_path)

        # From: CONUS_2.8_1.4_LC80470272014034LGN00_sr_band.tif
        # Extract each number in: 2.8_1.4
        # Where (2, 1) is the source coords, and .8/.4 are the sub sections of those tiles.
        components = self._dataset_path.stem.split('_')
        x_maj_min = components[1].split('.')
        y_maj_min = components[2].split('.')
        self.x_ref = int(x_maj_min[0]), int(x_maj_min[1])
        self.y_ref = int(y_maj_min[0]), int(y_maj_min[1])

        # Eg. 'USGS_SR_BAND'
        self._processing_level_code = ('usgs_' + ('_'.join(components[4:]))).upper()

        super(LandsatUsgsSrDataset, self).__init__(dataset_path)

    def _get_mtl_text(self):
        """Extract the mtl text."""
        return None

    @property
    def date_acquired(self):
        return datetime.strptime(self._md['acquisition_date'], '%Y-%m-%d').date()

    @property
    def _wrs_info(self):
        return yaml.load(self._md['wrs'])

    @property
    def extent(self):
        return _get_extent(self._ds.GetGeoTransform(),
                           self._ds.RasterXSize,
                           self._ds.RasterYSize)

    @property
    def coords(self):
        src_srs = osr.SpatialReference()
        src_srs.ImportFromWkt(self.get_projection())
        extent = self.extent
        co = reproject_coords(extent, src_srs)
        return co

    def _get_xml_text(self):
        """Extract the XML metadata text (if any)."""
        return None

    def get_satellite_tag(self):
        """A short unique string identifying the satellite."""
        sat = str(self._md['satellite'])

        if sat.startswith('LANDSAT'):
            return 'LS' + sat[-1]

    def get_sensor_name(self):
        """A short string identifying the sensor.

        The combination of satellite_tag and sensor_name must be unique.
        """
        sensor = self._md['instrument']
        if sensor == 'ETM':
            return 'ETM+'

        return sensor

    def get_processing_level(self):
        """A short string identifying the processing level or product.

        The processing level must be unique for each satellite and sensor
        combination.
        """
        return self._processing_level_code

    def get_x_ref(self):
        return int(self._wrs_info['path'])

    def get_y_ref(self):
        return int(self._wrs_info['row'])

    def get_start_datetime(self):
        """The start of the acquisition.

        This is a datetime without timezone in UTC.
        """
        return datetime.combine(self.date_acquired,
                                datetime.strptime('01:01:01', '%H:%M:%S').time())

    def get_end_datetime(self):
        """The end of the acquisition.

        This is a datatime without timezone in UTC.
        """
        return datetime.combine(self.date_acquired,
                                datetime.strptime('23:01:01', '%H:%M:%S').time())

    def get_ll_lat(self):
        return self.coords['ll'][0]

    def get_ll_lon(self):
        return self.coords['ll'][1]

    def get_ul_lat(self):
        return self.coords['ul'][0]

    def get_ul_lon(self):
        return self.coords['ul'][1]

    def get_lr_lat(self):
        return self.coords['lr'][0]

    def get_lr_lon(self):
        return self.coords['lr'][1]

    def get_ur_lat(self):
        return self.coords['ur'][0]

    def get_ur_lon(self):
        return self.coords['ur'][1]

    # ?
    get_ll_x = get_ll_lat
    get_ll_y = get_ll_lon
    get_lr_x = get_lr_lat
    get_lr_y = get_lr_lon
    get_ul_x = get_ul_lat
    get_ul_y = get_ul_lon
    get_ur_x = get_ur_lat
    get_ur_y = get_ur_lon

    def get_gcp_count(self):
        """The number of ground control points?"""
        return None

    def get_cloud_cover(self):
        """Percentage cloud cover of the aquisition if available."""
        return None

    def find_band_file(self, file_pattern):
        return self._path

    def stack_bands(self, band_dict):
        return PreTiledBandstack(self, band_dict)

    def get_tile_type_id(self):
        # Corresponds to 'Conus Albers WGS84 quarter degree' in v7__usgs_sr.sql
        return 6

    def get_tile_footprint(self):
        # We combine each major/minor tile number combination into a single number.
        return (self.x_ref[0] * 10 + self.x_ref[1]), (self.y_ref[0] * 10 + self.y_ref[1])
