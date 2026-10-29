-- View: public.vw_workforce_reporting

-- DROP VIEW public.vw_workforce_reporting;

CREATE OR REPLACE VIEW public.vw_workforce_reporting
 AS
 SELECT DISTINCT shift_id,
    staff_id,
    location_id,
    shift_date,
    shift_type,
        CASE
            WHEN TRIM(BOTH FROM scheduled_hours) ~ '^[0-9]+(\.[0-9]+)?$'::text THEN TRIM(BOTH FROM scheduled_hours)::numeric
            ELSE NULL::numeric
        END AS scheduled_hours,
        CASE
            WHEN TRIM(BOTH FROM worked_hours) ~ '^[0-9]+(\.[0-9]+)?$'::text THEN TRIM(BOTH FROM worked_hours)::numeric
            ELSE NULL::numeric
        END AS worked_hours,
    sickness_flag,
    agency_flag
   FROM rota_shifts;

ALTER TABLE public.vw_workforce_reporting
    OWNER TO postgres;

