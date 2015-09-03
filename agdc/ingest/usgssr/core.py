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
    Is this the filename of a SR file?
    :type f: str
    :rtype: bool
    """
    name = pathlib.Path(f).name
    return name.startswith('CONUS') and ('sr_band' in name)


class UsgsSRIngester(PreTiledIngester):
    """Ingester for USGS Surface Reflectance datasets."""

    def __init__(self, datacube=None, collection=None):
        super(UsgsSRIngester, self).__init__(_is_sr_dataset, datacube, collection)

    def open_dataset(self, dataset_path):
        return LandsatUsgsSrDataset(dataset_path)
