using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class DailyHotWordsExposed : System.Web.Services.WebService
{

    //[WebMethod]
    //public string HelloWorld()
    //{
    //    return "Hello World";
    //}

    //Get Daily new words List for all users
    [WebMethod]
    public System.Data.DataSet GetDailyNewWords()
    {
        System.Data.SqlClient.SqlConnection conPublic = new System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WordsDBconection"].ToString());
        System.Data.DataSet ds = new System.Data.DataSet();
        try
        {
            conPublic.Open();
            string sqlStr = @"
                SELECT   DISTINCT 
                J.id
                , W.contents                   
                , (SELECT TOP 1 CRF_Extractor.frequency  FROM CRF_Extractor WHERE CRF_Extractor.wordID = w.ID ORDER BY w_versionid DESC) AS  CRF_Extractorfrequency
                , (SELECT TOP 1 querylog_attri.queryCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriqueryCount
                , (SELECT TOP 1 querylog_attri.SearchResultCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriSearchResultCount
                , (SELECT TOP 1 querylog_attri.ClickCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriClickCount
                , (SELECT TOP 1 WatsonMis_attri.frequency  FROM WatsonMis_attri WHERE WatsonMis_attri.wordID = w.ID ORDER BY w_versionid DESC)AS  WatsonMis_attrifrequency
                , (SELECT TOP 1 UserRegistWords.registcount  FROM UserRegistWords WHERE UserRegistWords.wordID = w.ID ORDER BY w_versionid DESC) AS  UserRegistWordsregistcount
                , (SELECT TOP 1 NetworkHotList_attri.datASource  FROM NetworkHotList_attri WHERE NetworkHotList_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  NetworkHotList_attridatASource    
                FROM hot_lexicon_release AS J
                INNER JOIN word AS W  ON J.CHS = W.contents and J.isreleASed = 1 
                WHERE CAST(CONVERT(NVARCHAR(128), J.releasetime, 121) AS  NVARCHAR(10)) = CAST(CONVERT(NVARCHAR(128), GETDATE(), 121) AS NVARCHAR(10))
                ";
            System.Data.SqlClient.SqlDataAdapter dadTemp = new System.Data.SqlClient.SqlDataAdapter(sqlStr, conPublic);
            dadTemp.Fill(ds);

        }
        catch (Exception e)
        {
            conPublic.Close();
            return null;
        }
        finally
        {
            conPublic.Close();
        }
        return ds;
    }

    [WebMethod]
    public System.Data.DataSet GetSpecialDayNewWords(string strDate)
    {
        System.Data.SqlClient.SqlConnection conPublic = new System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WordsDBconection"].ToString());
        System.Data.DataSet ds = new System.Data.DataSet();
        try
        {
            conPublic.Open();
            string sqlStr = @"
                SELECT   DISTINCT 
                J.id
                , W.contents                   
                , (SELECT TOP 1 CRF_Extractor.frequency  FROM CRF_Extractor WHERE CRF_Extractor.wordID = w.ID ORDER BY w_versionid DESC) AS  CRF_Extractorfrequency
                , (SELECT TOP 1 querylog_attri.queryCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriqueryCount
                , (SELECT TOP 1 querylog_attri.SearchResultCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriSearchResultCount
                , (SELECT TOP 1 querylog_attri.ClickCount  FROM querylog_attri WHERE querylog_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  querylog_attriClickCount
                , (SELECT TOP 1 WatsonMis_attri.frequency  FROM WatsonMis_attri WHERE WatsonMis_attri.wordID = w.ID ORDER BY w_versionid DESC)AS  WatsonMis_attrifrequency
                , (SELECT TOP 1 UserRegistWords.registcount  FROM UserRegistWords WHERE UserRegistWords.wordID = w.ID ORDER BY w_versionid DESC) AS  UserRegistWordsregistcount
                , (SELECT TOP 1 NetworkHotList_attri.datASource  FROM NetworkHotList_attri WHERE NetworkHotList_attri.wordID = w.ID ORDER BY w_versionid DESC) AS  NetworkHotList_attridatASource    
                FROM hot_lexicon_release AS J
                INNER JOIN word AS W  ON J.CHS = W.contents and J.isreleASed = 1 
                WHERE CAST(CONVERT(NVARCHAR(128), J.releasetime, 121) AS  NVARCHAR(10)) = '";
            sqlStr += strDate;
            sqlStr += "'";
            System.Data.SqlClient.SqlDataAdapter dadTemp = new System.Data.SqlClient.SqlDataAdapter(sqlStr, conPublic);
            dadTemp.Fill(ds);

        }
        catch (Exception e)
        {
            conPublic.Close();
            return null;
        }
        finally
        {
            conPublic.Close();
        }
        return ds;
    }
}
