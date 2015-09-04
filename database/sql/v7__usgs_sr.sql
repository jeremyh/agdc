
-- One tile type
insert into tile_type (
    tile_type_id,
    tile_type_name,
    crs,
    x_origin, y_origin, x_size, y_size,
    x_pixels, y_pixels, unit, file_format, file_extension,
    tile_directory, format_options)
values
    (6,
     'Conus Albers WGS84 quarter degree',
     'PROJCS["Albers",
    GEOGCS["WGS 84",
        DATUM["WGS_1984",
            SPHEROID["WGS 84",6378137,298.257223563,
                AUTHORITY["EPSG","7030"]],
            AUTHORITY["EPSG","6326"]],
        PRIMEM["Greenwich",0],
        UNIT["degree",0.0174532925199433],
        AUTHORITY["EPSG","4326"]],
    PROJECTION["Albers_Conic_Equal_Area"],
    PARAMETER["standard_parallel_1",29.5],
    PARAMETER["standard_parallel_2",45.5],
    PARAMETER["latitude_of_center",23],
    PARAMETER["longitude_of_center",-96],
    PARAMETER["false_easting",0],
    PARAMETER["false_northing",0],
    UNIT["metre",1,
        AUTHORITY["EPSG","9001"]]]
     ',
     0, 0, 0.25, 0.25,
     1000, 1000, 'degree', 'GTiff', '.tif',
     'albers_quarter', 'COMPRESS=LZW');

-- Levels
insert into processing_level (level_id, level_name, nodata_value, resampling_method, level_description)
        values (71, 'USGS_SR_ATTR', -999, 'near', 'USGS Surface Reflectance attr');
insert into processing_level (level_id, level_name, nodata_value, resampling_method, level_description)
        values (72, 'USGS_SR_INT16_ATTR', -999, 'near', 'USGS Surface Reflectance int16 attr');
insert into processing_level (level_id, level_name, nodata_value, resampling_method, level_description)
        values (70, 'USGS_SR_BAND', -999, 'near', 'USGS Surface Reflectance band');
insert into processing_level (level_id, level_name, nodata_value, resampling_method, level_description)
        values (73, 'USGS_CFMASK', -999, 'near', 'USGS Surface Reflectance cloud-free mask');


-- Landsat 7 ETM+

-- Example: 'CONUS_3.2_1.0_LE70470262013359EDC00_cfmask.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (601, 3, 'usgs cfmask', 1, 1, 30, null, null, 'LE7.*_USGS_CFMASK.*', 2, 'USGS_CFMASK', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 601, 73, 1);
-- Example: 'CONUS_3.2_1.0_LE70470262013359EDC00_sr_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (611, 3, 'usgs sr adjacent cloud qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_ADJACENT_CLOUD_QA', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (612, 3, 'usgs sr cloud qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_CLOUD_QA', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (613, 3, 'usgs sr cloud shadow qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_CLOUD_SHADOW_QA', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (614, 3, 'usgs sr ddv qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_DDV_QA', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (615, 3, 'usgs sr fill qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_FILL_QA', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (616, 3, 'usgs sr land water qa', 1, 2, 30, null, null, 'LE7.*_USGS_SR_ATTR.*', 2, 'USGS_SR_LAND_WATER_QA', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 611, 71, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 612, 71, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 613, 71, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 614, 71, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 615, 71, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 616, 71, 6);
-- Example: 'CONUS_3.2_1.0_LE70470262013359EDC00_sr_band.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (621, 3, 'usgs sr atmos opacity', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_ATMOS_OPACITY', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (622, 3, 'usgs sr band1', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_BAND1', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (623, 3, 'usgs sr band2', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_BAND2', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (624, 3, 'usgs sr band3', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_BAND3', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (625, 3, 'usgs sr band4', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_BAND4', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (626, 3, 'usgs sr band5', 1, 3, 30, null, null, 'LE7.*_USGS_SR_BAND.*', 2, 'USGS_SR_BAND5', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 621, 70, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 622, 70, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 623, 70, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 624, 70, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 625, 70, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 626, 70, 6);
-- Example: 'CONUS_3.2_1.0_LE70470262013359EDC00_sr_int16_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (631, 3, 'usgs sr evi', 1, 4, 30, null, null, 'LE7.*_USGS_SR_INT16_ATTR.*', 2, 'USGS_SR_EVI', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 631, 72, 1);


-- Landsat 8 OLI_TIRS

-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_cfmask.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (641, 4, 'usgs cfmask', 1, 5, 30, null, null, 'L.8.*_USGS_CFMASK.*', 3, 'USGS_CFMASK', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 641, 73, 1);
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_attr.tif'
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_band.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (661, 4, 'usgs sr band1', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND1', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (662, 4, 'usgs sr band2', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND2', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (663, 4, 'usgs sr band3', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND3', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (664, 4, 'usgs sr band4', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND4', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (665, 4, 'usgs sr band5', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND5', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (666, 4, 'usgs sr band6', 1, 7, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND6', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 661, 70, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 662, 70, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 663, 70, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 664, 70, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 665, 70, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 666, 70, 6);
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_int16_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (671, 4, 'usgs sr evi', 1, 8, 30, null, null, 'L.8.*_USGS_SR_INT16_ATTR.*', 3, 'USGS_SR_EVI', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 671, 72, 1);


-- Landsat 8 OLI

-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_cfmask.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (681, 6, 'usgs cfmask', 1, 9, 30, null, null, 'L.8.*_USGS_CFMASK.*', 3, 'USGS_CFMASK', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 681, 73, 1);
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_attr.tif'
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_band.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (701, 6, 'usgs sr band1', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND1', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (702, 6, 'usgs sr band2', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND2', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (703, 6, 'usgs sr band3', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND3', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (704, 6, 'usgs sr band4', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND4', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (705, 6, 'usgs sr band5', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND5', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (706, 6, 'usgs sr band6', 1, 11, 30, null, null, 'L.8.*_USGS_SR_BAND.*', 3, 'USGS_SR_BAND6', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 701, 70, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 702, 70, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 703, 70, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 704, 70, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 705, 70, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 706, 70, 6);
-- Example: 'CONUS_3.2_1.0_LC80470272013303LGN00_sr_int16_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (711, 6, 'usgs sr evi', 1, 12, 30, null, null, 'L.8.*_USGS_SR_INT16_ATTR.*', 3, 'USGS_SR_EVI', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 711, 72, 1);


-- Landsat 5 TM

-- Example: 'CONUS_3.2_1.0_LT50470272010247PAC01_cfmask.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (721, 2, 'usgs cfmask', 1, 13, 30, null, null, 'LT5.*_USGS_CFMASK.*', 1, 'USGS_CFMASK', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 721, 73, 1);
-- Example: 'CONUS_3.2_1.0_LT50470272010247PAC01_sr_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (731, 2, 'usgs sr adjacent cloud qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_ADJACENT_CLOUD_QA', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (732, 2, 'usgs sr cloud qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_CLOUD_QA', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (733, 2, 'usgs sr cloud shadow qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_CLOUD_SHADOW_QA', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (734, 2, 'usgs sr ddv qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_DDV_QA', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (735, 2, 'usgs sr fill qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_FILL_QA', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (736, 2, 'usgs sr land water qa', 1, 14, 30, null, null, 'LT5.*_USGS_SR_ATTR.*', 1, 'USGS_SR_LAND_WATER_QA', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 731, 71, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 732, 71, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 733, 71, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 734, 71, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 735, 71, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 736, 71, 6);
-- Example: 'CONUS_3.2_1.0_LT50470272010247PAC01_sr_band.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (741, 2, 'usgs sr atmos opacity', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_ATMOS_OPACITY', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (742, 2, 'usgs sr band1', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_BAND1', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (743, 2, 'usgs sr band2', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_BAND2', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (744, 2, 'usgs sr band3', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_BAND3', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (745, 2, 'usgs sr band4', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_BAND4', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (746, 2, 'usgs sr band5', 1, 15, 30, null, null, 'LT5.*_USGS_SR_BAND.*', 1, 'USGS_SR_BAND5', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 741, 70, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 742, 70, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 743, 70, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 744, 70, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 745, 70, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 746, 70, 6);
-- Example: 'CONUS_3.2_1.0_LT50470272010247PAC01_sr_int16_attr.tif'
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (751, 2, 'usgs sr evi', 1, 16, 30, null, null, 'LT5.*_USGS_SR_INT16_ATTR.*', 1, 'USGS_SR_EVI', 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 751, 72, 1);
