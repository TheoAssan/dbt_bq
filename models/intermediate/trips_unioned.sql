with greentrips as (
    select 
            -- identifiers
        vendorid,
        ratecodeid,
        pulocationid,
        dolocationid,

        --timestamp
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        {{get_trip_duration('lpep_dropoff_datetime','lpep_pickup_datetime')}} as trip_duration,

        --trip info
        store_and_fwd_flag,        
        passenger_count,
        trip_distance,
        trip_type,

        --payment info
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,        
        congestion_surcharge,
        'Green' as service_type
    from {{ref('stg_greentaxi__greendata_2024_partitioned')}}
),

yellowtrips as (
    select 
        -- identifiers 
        vendorid,
        ratecodeid,
        pulocationid,
        dolocationid,

        --timestamp
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        {{get_trip_duration('tpep_dropoff_datetime','tpep_pickup_datetime')}} as trip_duration,
        
        --trip info
        store_and_fwd_flag,
        passenger_count,
        trip_distance,        
        cast(1 as integer) as trip_type,  -- Yellow taxis only do street-hail (code 1)       

        --payment info
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        cast(0 as numeric) as ehail_fee,  -- Yellow taxis don't have ehail_fee
        improvement_surcharge,        
        total_amount,
        payment_type,
        congestion_surcharge,
        'Yellow' as service_type
    from {{ref('stg_yellowtaxi__yellowdata_2024_partitioned')}}
),

unioned as (
    select * from yellowtrips
    union all
    select * from greentrips
)

select * from unioned