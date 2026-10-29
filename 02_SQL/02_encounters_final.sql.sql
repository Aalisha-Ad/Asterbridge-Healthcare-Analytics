-- View: public.vw_encounters_final

-- DROP VIEW public.vw_encounters_final;

CREATE OR REPLACE VIEW public.vw_encounters_final
 AS
 SELECT encounter_id,
    record_version,
    patient_id,
    location_id,
    provider_id,
    department_name_raw,
    department_name_clean,
        CASE
            WHEN TRIM(BOTH FROM wait_minutes) ~ '^[0-9]+(\.[0-9]+)?$'::text THEN TRIM(BOTH FROM wait_minutes)::numeric
            ELSE NULL::numeric
        END AS wait_minutes
   FROM ( SELECT v.encounter_id,
            v.record_version,
            v.patient_id,
            v.location_id,
            v.provider_id,
            v.wait_minutes,
            v.department_name_raw,
            v.department_name_clean,
            row_number() OVER (PARTITION BY v.encounter_id ORDER BY (
                CASE
                    WHEN TRIM(BOTH FROM v.record_version) ~ '^[0-9]+$'::text THEN TRIM(BOTH FROM v.record_version)::integer
                    ELSE NULL::integer
                END) DESC NULLS LAST) AS row_num
           FROM vw_encounters_departments_v2 v) ranked
  WHERE row_num = 1;

ALTER TABLE public.vw_encounters_final
    OWNER TO postgres;

