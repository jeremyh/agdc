# coding=utf-8
"""
Water Objects from Space ingest classes.
"""
from __future__ import absolute_import
import logging

import pathlib

from ..pretiled import PreTiledIngester
from .dataset import LandsatUsgsSrDataset
_LOG = logging.getLogger(__name__)


def _is_sr_dataset(f):
    """
    Is this the filename of an SR image?

    Examples:

    :type f: str
    :rtype: bool

    >>> _is_sr_dataset(pathlib.Path('CONUS_2.0_1.4_LC80490272013349LGN00_cfmask.tif'))
    True
    >>> _is_sr_dataset('CONUS_2.0_1.4_LC80490272013349LGN00_sr_attr.tif')
    True
    >>> _is_sr_dataset('/tmp/something/CONUS_2.0_1.4_LC80490272013349LGN00_sr_band.tif')
    True
    >>> _is_sr_dataset('CONUS_2.0_1.4_LC80490272013349LGN00_sr_int16_attr.tif')
    True
    >>> _is_sr_dataset('CONUS_2.0_1.4_LC80490272013349LGN00_sr_int16_attr.tif')
    True
    >>> _is_sr_dataset('CONUS_2.0_1.4_LC80490272013349LGN00_sr_int16_attr.tif')
    True
    >>> _is_sr_dataset('CONUS_2.0_1.4_LC80490272013349LGN00_sr_int16_attr.tif.aux.xml')
    False
    >>> _is_sr_dataset('LS7_ETM_NBAR_P54_GANBAR01-002_100_080_20001225_B10.tif')
    False
    """
    p = pathlib.Path(f)
    return p.name.startswith('CONUS') and p.suffix.lower() == '.tif'


class UsgsSRIngester(PreTiledIngester):
    """Ingester for USGS Surface Reflectance datasets."""

    def __init__(self, datacube=None, collection=None):
        super(UsgsSRIngester, self).__init__(_is_sr_dataset, datacube, collection)

    def open_dataset(self, dataset_path):
        return LandsatUsgsSrDataset(dataset_path)
