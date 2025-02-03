DECLARE @firstname NVARCHAR(5),
@lastname NVARCHAR(7),
@countrycode NVARCHAR(4),
@mobilephone NVARCHAR(10),
@email NVARCHAR(32),
@address1 NVARCHAR(64),
@address2 NVARCHAR(64),
@city NVARCHAR(12),
@state NVARCHAR(16),
@zip INT,
@country NVARCHAR(64),
@linkedinurl NVARCHAR(MAX),
@githuburl NVARCHAR(MAX),
@titleforresume NVARCHAR(64),
@initialparagraph NVARCHAR(MAX),
@workexperienceheader NVARCHAR(32),
@mostrecenttitle NVARCHAR(MAX),
@workexp1title NVARCHAR(MAX),
@workexp1datestart NVARCHAR(7),
@workexp1dateend NVARCHAR(7),
@workexp1bulletpoint1 NVARCHAR(MAX),
@workexp1bulletpoint2 NVARCHAR(MAX),
@workexp1bulletpoint3 NVARCHAR(MAX),
@workexp2title NVARCHAR(MAX),
@workexp2datestart NVARCHAR(7),
@workexp2dateend NVARCHAR(7),
@workexp2bulletpoint1 NVARCHAR(MAX),
@workexp2bulletpoint2 NVARCHAR(MAX),
@workexp2bulletpoint3 NVARCHAR(MAX),
@workexp3title NVARCHAR(MAX),
@workexp3datestart NVARCHAR(7),
@workexp3dateend NVARCHAR(7),
@workexp3bulletpoint1 NVARCHAR(MAX),
@workexp3bulletpoint2 NVARCHAR(MAX),
@workexp3bulletpoint3 NVARCHAR(MAX),
@workexp4title NVARCHAR(MAX),
@workexp4datestart NVARCHAR(7),
@workexp4dateend NVARCHAR(7),
@workexp4bulletpoint1 NVARCHAR(MAX),
@workexp4bulletpoint2 NVARCHAR(MAX),
@workexp4bulletpoint3 NVARCHAR(MAX),
@workexp5title NVARCHAR(MAX),
@workexp5datestart NVARCHAR(7),
@workexp5dateend NVARCHAR(7),
@workexp5bulletpoint1 NVARCHAR(MAX),
@workexp5bulletpoint2 NVARCHAR(MAX),
@workexp5bulletpoint3 NVARCHAR(MAX)


SET @firstname = N'Jacob'
SET @lastname = N'Shuster'
SET @countrycode = N'+1'
SET @mobilephone = N'6604415510'
SET @email = N'jcbshuster@yahoo.com'
SET @address1 = N'1022 Church Street'
SET @address2 = NULL
SET @city = N'Eudora'
SET @state = N'Kansas'
SET @zip = 66025 -- Not typically needed when location is asked. Instead in the format of City, State, Country
SET @country = N'United States'
SET @linkedinurl = N'https://www.linkedin.com/in/jacob-shuster-bb015780/'
SET @githuburl = N'https://www.github.com/Jay-Shu'
SET @titleforresume = N'Database Analysis / Engineering'

/**
	Carriage Return is CHAR(10)
**/

SET @initialparagraph = N'Proven track record of spearheading the growth of the Technical Support' + CHAR(10) +
N'and Managed Services department through Database; Performance, Complex Queries, Tuning, Stored ' + CHAR(10) + 
N'Procedures, Root Cause Analysis, and ITSM. Contributing to the ecosystem ensuring the success of' + CHAR(10) +
N' customers and peers alike. Creating Proxy Databases for training Technical Support Analysts when ' + CHAR(10) +
N'one was not available allowed for streamlining testing and resolving customer issues. A process ' + CHAR(10) +
N'that could normally take weeks to months, had now been reduced to a few weeks at most. ' + CHAR(10) +
N'Within Managed Services using prior skills to assist Solution Consultants in gathering the' + CHAR(10) + 
N' required data to complete one or more given deliverables for the project onboarding. ' + CHAR(10) +
N'Without much assistance available outside of our group and Technical Support queries for ' + CHAR(10) +
N'ITSM were constructed for gathering such information. Making a manual process take a fraction ' + CHAR(10) +
N'of the time by running a query whose limit is the environment is resided in.'
SET @workexperienceheader = N'Work Experience'
SET @mostrecenttitle = N'Manager, Global Services, Managed Services'

SET @workexp1title = N'Manager, Global Services, Managed Services'
SET @workexp1datestart = N'06/2021'
SET @workexp1dateend = N'04/2023'
SET @workexp1bulletpoint1 = N'Engineered queries for gathering data related to the Configuration Management Database ' + CHAR(10) +
N'for Hyland OnBase and Perceptive Content. Reducing a manual lengthy process by 300% to ' + CHAR(10) + N'a more manageable process.'
SET @workexp1bulletpoint2 = N'Assisted in locating and modifying of queries from past use to future use. This included ' + CHAR(10) +
N'the Knowledge Base as well as 6.83 years of Microsoft OneNote. Consolidation of queries ' + CHAR(10) +
N'relevant to Managed Services. Reducing related issues to one-and-done.'
SET @workexp1bulletpoint3 = N'Led weekly standups for the developers of the Managed Services team for ensuring a smooth ' + CHAR(10) +
N'code writing based upon RFC structure. Setting the standard for future additions to the team ' + CHAR(10) +
N'to be easily augmented and pick up the work. Instead of starting at 0 when working on a previous ' + CHAR(10) + N'colleagues work, this gave them a 100% clear view.'
SET @workexp2title = N'Technical Support Analyst 4 / Team Lead'
SET @workexp2datestart = N'11/2019'
SET @workexp2dateend = N'06/2021'
SET @workexp2bulletpoint1 = N'Designed queries for troubleshooting deep-seeded issues reducing troubleshooting time for '
SET @workexp2bulletpoint2 = N'Assisted in locating and modifying of queries from past use to future use. This included ' + CHAR(10) +
N'the Knowledge Base as well as 6.83 years of Microsoft OneNote. Consolidation of queries ' + CHAR(10) +
N'relevant to Managed Services. Reducing related issues to one-and-done.'
SET @workexp2bulletpoint3 = N'Led weekly standups for the developers of the Managed Services team for ensuring a smooth ' + CHAR(10) +
N'code writing based upon RFC structure. Setting the standard for future additions to the team ' + CHAR(10) +
N'to be easily augmented and pick up the work. Instead of starting at 0 when working on a previous ' + CHAR(10) + N'colleagues work, this gave them a 100% clear view.'
SET @workexp3title = N'Technical Support Analyst 3'
SET @workexp3datestart = N'08/2018'
SET @workexp3dateend = N'11/2019'
SET @workexp4title = N'Technical Support Analyst 2'
SET @workexp4datestart = N'08/2015'
SET @workexp4dateend = N'08/2018'
SET @workexp4title = N'Technical Support Analyst 1'
SET @workexp4datestart = N'02/2015'
SET @workexp4dateend = N'08/2015'


PRINT REPLICATE(CHAR(9),7) + @firstname + N' ' + @lastname + REPLICATE(CHAR(9),7)
PRINT REPLICATE(CHAR(9),2) + N'Mobile: ' + @countrycode + @mobilephone + CHAR(32) + CHAR(124) + CHAR(32)
+ @city + CHAR(44) + CHAR(32) + @state + CHAR(44) + CHAR(32) + @country + CHAR(32) + CHAR(124) + CHAR(32)
PRINT @linkedinurl + CHAR(32) + CHAR(124) + CHAR(32) + @githuburl
PRINT N''
PRINT @titleforresume
PRINT REPLICATE(CHAR(9),2) + @initialparagraph
PRINT N''
PRINT @workexperienceheader
PRINT N'Title: ' + @workexp1title
PRINT N'Date Start: ' + @workexp1datestart
PRINT N'Date End: ' + @workexp1dateend
PRINT N'Reason: Layoff'
PRINT N''
PRINT CHAR(45) + CHAR(9) + @workexp1bulletpoint1
PRINT CHAR(45) + CHAR(9) + @workexp1bulletpoint2
PRINT CHAR(45) + CHAR(9) + @workexp1bulletpoint3
PRINT N''
PRINT N''
PRINT N'Title: ' + @workexp2title
PRINT N'Date Start: ' + @workexp2datestart
PRINT N'Date End: ' + @workexp2dateend
PRINT N'Reason: Promotion'
PRINT N''
PRINT CHAR(45) + CHAR(9) + @workexp2bulletpoint1
PRINT CHAR(45) + CHAR(9) + @workexp2bulletpoint2
PRINT CHAR(45) + CHAR(9) + @workexp2bulletpoint3