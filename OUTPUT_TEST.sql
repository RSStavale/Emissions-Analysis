-- INSERT INTO emissions_agriculture_energy_result(
-- 	country,
-- 	item,
-- 	element,
-- 	year,
-- 	unit,
-- 	value
-- 	)SELECT 
--   country,
--   item,
--   element,
--   year,
--   unit,
--   value
-- FROM 
--   public.emissions_agriculture_energy;
--   select * from emissions_agriculture_energy_result;
  
--Transposição da tabela
select colpivot('_output',
    'select * emissions_agriculture_burning_crop_residues_result',
array['country','year'], array['item','element'], '#.value', null);


CREATE TABLE emissions_agriculture_burning_crop_residues_final AS (select * from _output);

select * from emissions_agriculture_burning_crop_residues_final  where country = 'Afghanistan'


--select * from emissions_agriculture_burning_crop_residues_result where country = 'R?ion' AND item = 'Rice, paddy';