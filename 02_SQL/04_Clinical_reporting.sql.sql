-- View: public.vw_clinical_reporting

-- DROP VIEW public.vw_clinical_reporting;

CREATE OR REPLACE VIEW public.vw_clinical_reporting
 AS
 WITH ranked_clinical AS (
         SELECT e.encounter_id,
            e.record_version,
            e.encounter_type,
            e.outcome,
            e.ingest_ts,
            row_number() OVER (PARTITION BY e.encounter_id ORDER BY (
                CASE
                    WHEN TRIM(BOTH FROM e.record_version) ~ '^[0-9]+$'::text THEN TRIM(BOTH FROM e.record_version)::integer
                    ELSE NULL::integer
                END) DESC NULLS LAST, (
                CASE
                    WHEN TRIM(BOTH FROM e.ingest_ts) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$'::text THEN to_timestamp(TRIM(BOTH FROM e.ingest_ts), 'MM/DD/YYYY HH24:MI'::text)
                    ELSE NULL::timestamp with time zone
                END) DESC NULLS LAST, e.scheduled_ts DESC NULLS LAST) AS row_num
           FROM encounters e
        )
 SELECT r.encounter_id,
    r.record_version,
    r.patient_id,
    r.location_id,
    r.provider_id,
    r.department_name_clean,
    r.wait_minutes,
    r.scheduled_datetime,
    r.encounter_date,
    c.encounter_type,
    c.outcome
   FROM vw_encounters_reporting r
     LEFT JOIN ranked_clinical c ON r.encounter_id::text = c.encounter_id::text AND c.row_num = 1;

ALTER TABLE public.vw_clinical_reporting
    OWNER TO postgres;

