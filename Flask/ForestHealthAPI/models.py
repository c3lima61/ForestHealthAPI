from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class ForestData(db.Model):
    __tablename__ = 'forest_data'

    id = db.Column(db.Integer, primary_key=True)
    species = db.Column(db.String(80), nullable=False)
    health_status = db.Column(db.String(120), nullable=False)
    location = db.Column(db.String(120), nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False)

def get_sample_counts(start_date, end_date):
    query = """
    WITH Samples AS (
      SELECT CUSTOMER.custid,
             CUSTOMER.cust_name,
             CRSF.site_name,
             EQUIPMENT.serialno,
             EQUIPMENT.unitno,
             MAKE.makeid,
             MAKE.makedesc,
             MODEL.modelid,
             COALESCE(LU_EQUIP_REG_INDUSTRY.industry_name, 'Other') AS industry_name,
             LU_COMPART.compartid,
             LU_COMPART.compart,
             SAMPLE_ID.labno,
             LU_TEST_TYPE.test_type_desc,
             LU_TEST_CATEGORY.test_category,
             SAMPLE.evalcode,
             SAMPLE.processdate,
             SAMPLE.created_date,
             SAMPLE.express_date
      FROM CUSTOMER
      LEFT JOIN CRSF ON CRSF.customer_auto = CUSTOMER.customer_auto
      LEFT JOIN EQUIPMENT ON EQUIPMENT.crsf_auto = CRSF.crsf_auto
      LEFT JOIN LU_MMTA ON LU_MMTA.mmtaid_auto = EQUIPMENT.mmtaid_auto
      LEFT JOIN MAKE ON MAKE.make_auto = LU_MMTA.make_auto
      LEFT JOIN MODEL ON MODEL.model_auto = LU_MMTA.model_auto
      LEFT JOIN LU_EQUIP_REG_INDUSTRY ON LU_EQUIP_REG_INDUSTRY.equip_reg_industry_auto = MODEL.equip_reg_industry_auto
      LEFT JOIN EQ_UNIT ON EQ_UNIT.equipmentid_auto = EQUIPMENT.equipmentid_auto
      LEFT JOIN LU_COMPART ON LU_COMPART.compartid_auto = EQ_UNIT.compartid_auto
      LEFT JOIN SAMPLE_ID ON SAMPLE_ID.equnit_auto = EQ_UNIT.equnit_auto
      LEFT JOIN LU_TEST_TYPE ON LU_TEST_TYPE.test_type_auto = SAMPLE_ID.test_type_auto
      LEFT JOIN LU_TEST_CATEGORY ON LU_TEST_CATEGORY.test_category_auto = LU_TEST_TYPE.test_category_auto
      WHERE SAMPLE_ID.express_date >= :start_date
        AND SAMPLE_ID.express_date < :end_date
    )

    SELECT DATE_TRUNC('day', express_date) AS "Day",
           test_category AS "Sample Type",
           COUNT(*) AS "No. Samples"
    FROM Samples
    GROUP BY DATE_TRUNC('day', express_date),
             test_category
    ORDER BY test_category;
    """
    result = db.session.execute(query, {'start_date': start_date, 'end_date': end_date})
    return result.fetchall()

