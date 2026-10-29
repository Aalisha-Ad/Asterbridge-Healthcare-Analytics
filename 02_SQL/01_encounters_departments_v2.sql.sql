-- View: public.vw_encounters_departments_v2

-- DROP VIEW public.vw_encounters_departments_v2;

CREATE OR REPLACE VIEW public.vw_encounters_departments_v2
 AS
 WITH standardised AS (
         SELECT encounters.encounter_id,
            encounters.record_version,
            encounters.patient_id,
            encounters.location_id,
            encounters.provider_id,
            encounters.department_name_raw,
            encounters.treatment_code,
            encounters.treatment_description_raw,
            encounters.encounter_type,
            encounters.scheduled_ts,
            encounters.wait_minutes,
            encounters.outcome,
            encounters.length_of_stay_days,
            encounters.related_encounter_id,
            encounters.ingest_ts,
            lower(regexp_replace(TRIM(BOTH FROM encounters.department_name_raw), '\s+'::text, ' '::text, 'g'::text)) AS department_key
           FROM encounters
        )
 SELECT encounter_id,
    record_version,
    patient_id,
    location_id,
    provider_id,
    wait_minutes,
    department_name_raw,
        CASE
            WHEN department_key IS NULL OR department_key = ''::text THEN 'Unknown'::text
            WHEN department_key = ANY (ARRAY['physiotherapy'::text, 'physiother.'::text]) THEN 'Physiotherapy'::text
            WHEN department_key = ANY (ARRAY['cardiology'::text, 'cardiol.'::text]) THEN 'Cardiology'::text
            WHEN department_key = ANY (ARRAY['orthopaedics'::text, 'orthopedics'::text, 'orthopaed.'::text]) THEN 'Orthopaedics'::text
            WHEN department_key = ANY (ARRAY['mental health'::text, 'mental hea.'::text]) THEN 'Mental Health'::text
            WHEN department_key = ANY (ARRAY['ophthalmology'::text, 'ophthalmol.'::text]) THEN 'Ophthalmology'::text
            WHEN department_key = ANY (ARRAY['palliative care'::text, 'palliative c.'::text]) THEN 'Palliative Care'::text
            WHEN department_key = ANY (ARRAY['rehabilitation'::text, 'rehabilitat.'::text]) THEN 'Rehabilitation'::text
            WHEN department_key = ANY (ARRAY['dermatology'::text, 'dermatol.'::text]) THEN 'Dermatology'::text
            WHEN department_key = ANY (ARRAY['general medicine'::text, 'general medic.'::text]) THEN 'General Medicine'::text
            WHEN department_key = ANY (ARRAY['diagnostics & imaging'::text, 'diagnostics and imaging'::text, 'diagnostics & imag.'::text]) THEN 'Diagnostics & Imaging'::text
            ELSE initcap(department_key)
        END AS department_name_clean
   FROM standardised;

ALTER TABLE public.vw_encounters_departments_v2
    OWNER TO postgres;

