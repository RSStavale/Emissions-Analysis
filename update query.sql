SELECT distinct
  item, 
  element
FROM 
  emissions_agriculture_burning_savanna_result;

  UPDATE 
  emissions_agriculture_burning_savanna_result 
  set element = 'Emissions(N2O)BurningCropResidues' 
  where element = 'Emissions (N2O) (Burning crop residues)';

  SELECT distinct
  item, 
  element
FROM 
  emissions_agriculture_burning_savanna_result;