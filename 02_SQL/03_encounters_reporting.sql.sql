-- View: public.vw_encounters_reporting

-- DROP VIEW public.vw_encounters_reporting;

CREATE OR REPLACE VIEW public.vw_encounters_reporting
 AS
 WITH ranked_encounters AS (
         SELECT encounters.encounter_id,
            encounters.record_version,
            encounters.scheduled_ts,
            encounters.ingest_ts,
            row_number() OVER (PARTITION BY encounters.encounter_id ORDER BY (
                CASE
                    WHEN TRIM(BOTH FROM encounters.record_version) ~ '^[0-9]+$'::text THEN TRIM(BOTH FROM encounters.record_version)::integer
                    ELSE NULL::integer
                END) DESC NULLS LAST, (
                CASE
                    WHEN TRIM(BOTH FROM encounters.ingest_ts) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$'::text THEN to_timestamp(TRIM(BOTH FROM encounters.ingest_ts), 'MM/DD/YYYY HH24:MI'::text)
                    ELSE NULL::timestamp with time zone
                END) DESC NULLS LAST, encounters.scheduled_ts DESC NULLS LAST) AS row_num
           FROM encounters
        )
 SELECT f.encounter_id,
    f.record_version,
    f.patient_id,
    f.location_id,
    f.provider_id,
    f.department_name_clean,
    f.wait_minutes,
    to_timestamp(TRIM(BOTH FROM r.scheduled_ts), 'MM/DD/YYYY HH24:MI'::text)::timestamp without time zone AS scheduled_datetime,
    to_timestamp(TRIM(BOTH FROM r.scheduled_ts), 'MM/DD/YYYY HH24:MI'::text)::date AS encounter_date
   FROM vw_encounters_final f
     JOIN ranked_encounters r ON f.encounter_id::text = r.encounter_id::text AND r.row_num = 1;

ALTER TABLE public.vw_encounters_reporting
    OWNER TO postgres;

