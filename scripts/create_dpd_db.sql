.mode csv
.separator ","

CREATE TABLE "drug" ("DRUG_CODE" INTEGER(8) PRIMARY KEY  NOT NULL , "PRODUCT_CATEGORIZATION" VARCHAR2(80), "CLASS" VARCHAR2(40), "DRUG_IDENTIFICATION_NUMBER" VARCHAR2(8), "BRAND_NAME" VARCHAR2(200), "DESCRIPTOR" VARCHAR(150), "PEDIATRIC_FLAG" VARCHAR2(1), "ACCESSION_NUMBER" VARCHAR2(5), "NUMBER_OF_AIS" VARCHAR2(10), "LAST_UPDATE_DATE" DATE, "AI_GROUP_NO" VARCHAR2(10));

CREATE TABLE "form" ("DRUG_CODE" INTEGER(8) NOT NULL , "PHARM_FORM_CODE" INTEGER(7), "PHARMACEUTICAL_FORM" VARCHAR2(40));

CREATE TABLE "route" ("DRUG_CODE" INTEGER(8)  NOT NULL , "ROUTE_OF_ADMINISTRATION_CODE" INTEGER(6), "ROUTE_OF_ADMINISTRATION" VARCHAR2(40));

CREATE  TABLE "status" ("DRUG_CODE" INTEGER(8)  NOT NULL , "CURRENT_STATUS_FLAG" VARCHAR2(1), "STATUS" VARCHAR2(40), "HISTORY_DATE" DATE);

CREATE TABLE "ingred" ("DRUG_CODE" INTEGER(8) NOT NULL , "ACTIVE_INGREDIENT_CODE" INTEGER(6), "INGREDIENT" VARCHAR2(240), "INGREDIENT_SUPPLIED_IND" VARCHAR2(1), "STRENGTH" VARCHAR2(20), "STRENGTH_UNIT" VARCHAR2(40), "STRENGTH_TYPE" VARCHAR2(40), "DOSAGE_VALUE" VARCHAR2(20), "BASE" VARCHAR2(1), "DOSAGE_UNIT" VARCHAR2(40), "NOTES" VARCHAR2(2000));

CREATE TABLE "ther" ("DRUG_CODE" INTEGER(8) NOT NULL , "TC_ATC_NUMBER" VARCHAR2(8), "TC_ATC" VARCHAR2(120), "TC_AHFS_NUMBER" VARCHAR2(20), "TC_AHFS" VARCHAR2(80));

CREATE TABLE "package" ("DRUG_CODE" INTEGER(8) NOT NULL , "UPC" VARCHAR2(12), "PACKAGE_SIZE_UNIT" VARCHAR2(40), "PACKAGE_TYPE" VARCHAR2(40), "PACKAGE_SIZE" VARCHAR2(5), "PRODUCT_INFORMATION" VARCHAR2(80));

.import drug.txt drug
.import form.txt form
.import route.txt route
.import status.txt status
.import ingred.txt ingred
.import ther.txt ther
.import package.txt package

.exit