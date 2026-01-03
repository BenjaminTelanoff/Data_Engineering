-- In here we imputed all missing values, we found out that missing values in results were due to reasons outside of dq, dns, and dnf
-- So we just removed those rows
BEGIN;

UPDATE swimming
SET Athlete = CASE
    WHEN Year = 2016 AND Team = 'CHN' AND DISTANCE = '4x100' AND Stroke = 'Medley' AND Gender = 'Women' THEN 'Yuanhui FU, Ying LU, Duo SHEN, Jinglin SHI, Menghui ZHU, Xinyu ZHANG'
    WHEN Year = 2016 AND Team = 'CAN' AND DISTANCE = '4x100' AND Stroke = 'Medley' AND Gender = 'Women' THEN 'Chantal VAN LANDEGHEM, Kylie MASSE, Noemie THOMAS, Penny OLEKSIAK, Rachel NICOL, Taylor Madison RUCK'
    WHEN Year = 2016 AND Team = 'RUS' AND DISTANCE = '4x100' AND Stroke = 'Medley' AND Gender = 'Women' THEN 'Anastasiia FESIKOVA, Yuliya EFIMOVA, Svetlana CHIMROVA, Veronika ANDRUSENKO'
    WHEN Year = 2016 AND Team = 'GBR' AND DISTANCE = '4x100' AND Stroke = 'Medley' AND Gender = 'Women' THEN 'Francesca HALSALL, Georgia DAVIES, Chloe TUTTON, Georgia COATES, Siobhan-Marie OCONNOR'
    WHEN Year = 2016 AND Team = 'GER' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Paul BIEDERMANN, Clemens RAPP, Christoph FILDEBRANDT, Florian VOGEL, Jacob HEIDTMANN'
    WHEN Year = 2008 AND Team = 'USA' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Michael PHELPS, Ryan LOCHTE, Ricky BERENS, Peter VANDERKAAY, David WALTERS, Erik VENDT, Klete KELLER'
    WHEN Year = 2000 AND Team = 'AUS' AND DISTANCE = '4x100' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Michael KLIM, Christopher John FYDLER, Ashley CALLUS, Ian THORPE, Todd PEARSON, Adam PINE'
    WHEN Year = 2000 AND Team = 'ITA' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Andrea BECCARI, Matteo PELLICIARI, Emiliano BREMBILLA, Massimiliano ROSOLINO, Simone CERCATO, Klaus LANZARINI'
    WHEN Year = 1996 AND Team = 'USA' AND DISTANCE = '4x100' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Jon OLSEN, Josh DAVIS, Bradley SCHUMACHER, Gary HALL Jr., David FOX, Scott TUCKER'
    WHEN Year = 1988 AND Team = 'AUS' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Thomas STACHEWICZ, Ian Robert BROWN, Jason PLUMMER, Duncan ARMSTRONG, Martin Wade ROBERTS'
    WHEN Year = 1988 AND Team = 'FRA' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Michel POU, Franck IACONO, Olivier FOUGEROUD, Ludovic DEPICKERE, Stephan CARON, Laurent NEUVILLE'
    WHEN Year = 1960 AND Team = 'JPN' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Makoto FUKUI, Hiroshi ISHII, Tsuyoshi YAMANAKA, Tatsuo FUJIMOTO'
    WHEN Year = 1928 AND Team = 'ESP' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'José GONZÁLEZ, Estanislao ARTAL, Ramón ARTIGAS, Francisco SEGALÁ'
    WHEN Year = 1924 AND Team = 'USA' AND DISTANCE = '4x200' AND Stroke = 'Freestyle' AND Gender = 'Men' THEN 'Ralph BREYER, Harrison Smith GLANCY, Wally O''CONNOR, Johnny WEISSMULLER, Richard HOWELL'
    ELSE Athlete
END;

DELETE FROM swimming
WHERE RESULTS = '';

COMMIT;
