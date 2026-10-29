-- View: public.vw_incidents_reporting

-- DROP VIEW public.vw_incidents_reporting;

CREATE OR REPLACE VIEW public.vw_incidents_reporting
 AS
 SELECT incident_id,
    location_id,
    patient_id,
    category,
    severity,
        CASE
            WHEN TRIM(BOTH FROM incident_ts) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$'::text THEN to_timestamp(TRIM(BOTH FROM incident_ts), 'MM/DD/YYYY HH24:MI'::text)::date
            ELSE NULL::date
        END AS incident_date
   FROM incidents;

ALTER TABLE public.vw_incidents_reporting
    OWNER TO postgres;

