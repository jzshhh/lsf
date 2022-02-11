# lsf
lsf is designed for extracting hydrological loading displacement form GNSS vertical position time series analysis based on the least squares fitting method.


# Attribution
lsf is designed for extracting hydrological loading displacement form GNSS vertical position time series analysis based on the least squares fitting method. It is a modified version of Tsview software (http://www-gpsg.mit.edu/~tah/GGMatlab/#_tsview) (Herring, 2003)) and is suitable for batch processing of GNSS time series.

# Preparing some relevant files
When implementing this software, readers need to prepare some relevant files:
1. GNSS data file (*.pos). The GNSS position time series at each station are saved in a single file (*.pos) and all of them are placed in the folder (pbo/).
2. Offset data file (‘*_break.neu’). The offset data files are saved in ‘*_break.neu’ for each station and readers need to manually make these files. Different formats indicate different types of breakpoints, including instrumental offsets (e.g., 2011.37808219178  9999.99999999999  0  0), seismic offsets (e.g., 2011.37808219178  9999.99999999999  0  1), rate changes (e.g., 2011.37808219178  9999.99999999999  1  0), exponential postseismic term (e.g., 2011.37808219178  60  2  0) and logarithmic postseismic term (e.g., 2011.37808219178  60  2  1).
3. NTAL (*.ntal), NTOL (*.ntol) and GIA (*.gia) files. obtain non-tidal atmospheric and oceanic loading displacements from the German Center for Geoscience (http://esmdata.gfz-potsdam.de:8080/repository) and GIA effects from the webpage (https://www.atmosp.physics.utoronto.ca/~peltier/data.php).


# To acknowledge use of this software, please cite the following publication
Herring, T. (2003). MATLAB Tools for viewing GPS velocities and time series. GPS Solutions, 7, 194–199. doi: 10.1007/s10291-003-0068-0
Jiang Z., Hsu Y., Yuan L., Cheng S., Feng W., Tang M., Yang X, 2022. Insights into hydrological drought characteristics using GNSS-inferred large-scale terrestrial water storage deficits, Earth and Planetary Science Letters, 578, 117294. doi: 10.1016/j.epsl.2021.117294
Jiang Z., Hsu Y., Yuan L., Tang M., Yang X., Yang X., 2022. Hydrological drought characterization based on GNSS imaging of vertical crustal deformation across the contiguous United States. Science of the Total Environment, 823, 153663. doi: 10.1016/j.scitotenv.2022.15366
Jiang, Z., Hsu, Y.-J., Yuan, L., Cheng, S., Li, Q., Li, M., 2021b. Estimation of daily hydrological mass changes using continuous GNSS measurements in mainland China. Journal of Hydrology 598. doi: 10.1016/j.jhydrol.2021.126349
Jiang, Z., Hsu, Y.-J., Yuan, L., Huang, D., 2021c. Monitoring time-varying terrestrial water storage changes using daily GNSS measurements in Yunnan, southwest China. Remote Sensing of Environment 254. doi: 10.1016/j.rse.2020.112249
Jiang, Z., Hsu, Y.J., Yuan, L., Yang, X., Ding, Y., Tang, M., Chen, C., 2021d. Characterizing Spatiotemporal Patterns of Terrestrial Water Storage Variations Using GNSS Vertical Data in Sichuan, China. Journal of Geophysical Research: Solid Earth 126. doi: 10.1029/2021jb022398
