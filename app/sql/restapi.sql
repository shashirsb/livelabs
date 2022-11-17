-- SPATIAL REST API GET

with x as (SELECT
    t1.pk_col,
    t1.pin_code,
    t1.store_address,
    t1.store_name,
    sdo_nn_distance(5)                      distance_m,
    get_geometry(t1.longitude, t1.latitude) geometry
FROM
    ouser.online_stores t1
WHERE
        sdo_nn(admin.get_geometry(t1.longitude, t1.latitude),
               mdsys.sdo_geometry(2001,
                                  4326,
                                  sdo_point_type(1.3222376155648177, 103.84562334102512, NULL),
                                  NULL,
                                  NULL),
               'sdo_batch_size=10 unit=KM',
               5) = 'TRUE'
    AND ROWNUM <= 10
    )
 SELECT 'application/json' as mediatype, -- for ORDS,
    '{"type": "FeatureCollection", "features":'
    || JSON_ARRAYAGG( 
        '{"type": "Feature", "properties": {'
        || '"pk_col":"'|| pk_col
        ||'","pin_code":"'|| pin_code
        ||'","store_address":"'|| store_address
        ||'","store_name":"'|| store_name
        ||'","distance_m":"'|| distance_m
        ||'"}, "geometry":'|| SDO_UTIL.TO_GEOJSON(Geometry)
        ||'}' 
       FORMAT JSON RETURNING CLOB) 
    ||'}'
    AS GEOJSON
FROM X

-- INSERT ORDER REST API POST

INSERT INTO ouser.j_onlineorder VALUES (SYS_GUID(),to_date(to_char(sysdate,'dd/mon/yyyy hh24:mi:ss'), 'dd/mm/yyyy hh24:mi:ss' ),'{"ORDERDATE":"03-20-2022","ORDERTIME":"8:05 AM","ORDER_LINEID":"965","ORDERQUANTITY":"4","ITEMID":"4","ORDERAMOUNT":"872.63","ORDERID":"742","LATITUDE":"","LONGITUDE":""}');
