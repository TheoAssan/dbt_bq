with 

source as (

    select * from {{ source('yellowtaxi', 'yellowdata_2024_partitioned') }}

),

renamed as (

    select
        -- identifiers 
        vendorid,
        ratecodeid,
        pulocationid,
        dolocationid,

        --timestamp
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        
        --trip info
        passenger_count,
        trip_distance,
        store_and_fwd_flag,
        
        --payment info
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee

    from source
    where vendorid is not null
)

select * from renamed