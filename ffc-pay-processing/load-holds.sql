INSERT INTO public.holds (
    "frn", "holdCategoryId", added
)
SELECT
    holds."FRN",
    9,
    NOW()
FROM public."tempHolds" holds
