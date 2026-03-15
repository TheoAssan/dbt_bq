 with 

source as (

    select * from {{ source('greentaxi', 'greendata_2024_partitioned') }}

),

renamed as (

    select
        -- identifiers
        vendorid,
        ratecodeid,
        pulocationid,
        dolocationid,

        --timestamp
        lpep_pickup_datetime,
        lpep_dropoff_datetime,

        --trip info
        store_and_fwd_flag,        
        passenger_count,
        trip_distance,

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
        trip_type,
        congestion_surcharge

    from source
    where vendorid is not null
)

select * from renamed