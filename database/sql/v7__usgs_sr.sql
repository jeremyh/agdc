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
insert into processing_level (level_id, level_name, nodata_value, resampling_method, level_description)
values (7, 'USGSSR', -999, 'near', 'USGS Surface Reflectance');


-- Landsat 7 ETM+

insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (601, 3, 'sr_atmos_opacity', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_atmos_opacity', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (602, 3, 'sr_band1', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_band1', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (603, 3, 'sr_band2', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_band2', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (604, 3, 'sr_band3', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_band3', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (605, 3, 'sr_band4', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_band4', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (606, 3, 'sr_band5', 1, null, 30, null, null, 'LE7.*_sr_band.*', 2, 'sr_band5', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 601, 7, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 602, 7, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 603, 7, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 604, 7, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 605, 7, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 606, 7, 6);


-- Landsat 8 OLI_TIRS

insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (611, 4, 'sr_band1', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band1', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (612, 4, 'sr_band2', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band2', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (613, 4, 'sr_band3', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band3', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (614, 4, 'sr_band4', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band4', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (615, 4, 'sr_band5', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band5', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (616, 4, 'sr_band6', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band6', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 611, 7, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 612, 7, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 613, 7, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 614, 7, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 615, 7, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 616, 7, 6);


-- Landsat 8 OLI

insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (621, 6, 'sr_band1', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band1', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (622, 6, 'sr_band2', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band2', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (623, 6, 'sr_band3', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band3', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (624, 6, 'sr_band4', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band4', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (625, 6, 'sr_band5', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band5', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (626, 6, 'sr_band6', 1, null, 30, null, null, 'L.8.*_sr_band.*', 3, 'sr_band6', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 621, 7, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 622, 7, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 623, 7, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 624, 7, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 625, 7, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 626, 7, 6);


-- Landsat 5 TM

insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (631, 2, 'sr_atmos_opacity', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_atmos_opacity', 1);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (632, 2, 'sr_band1', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_band1', 2);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (633, 2, 'sr_band2', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_band2', 3);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (634, 2, 'sr_band3', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_band3', 4);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (635, 2, 'sr_band4', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_band4', 5);
insert into band (band_id, sensor_id, band_name, band_type_id, file_number, resolution, min_wavelength, max_wavelength, file_pattern, satellite_id, band_tag, band_number)
values (636, 2, 'sr_band5', 1, null, 30, null, null, 'LT5.*_sr_band.*', 1, 'sr_band5', 6);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 631, 7, 1);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 632, 7, 2);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 633, 7, 3);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 634, 7, 4);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 635, 7, 5);
insert into band_source (tile_type_id, band_id, level_id, tile_layer) values (6, 636, 7, 6);
