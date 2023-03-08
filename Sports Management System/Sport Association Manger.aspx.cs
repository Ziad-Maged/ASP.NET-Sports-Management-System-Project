using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Web.Configuration;

namespace Milestone_3
{
    public partial class Sport_Association_Manger : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Hostclub = hostclub.Text;
            String Guestclub = guestclub.Text;
            String Starttime = starttime.Text;
            String Endtime = endtime.Text;



            SqlCommand addNewMatch = new SqlCommand("addNewMatch", conn);
            addNewMatch.CommandType = CommandType.StoredProcedure;
            addNewMatch.Parameters.Add(new SqlParameter("@host_club", Hostclub));
            addNewMatch.Parameters.Add(new SqlParameter("@guost_club", Guestclub));
            addNewMatch.Parameters.Add(new SqlParameter("@start_time", Starttime));
            addNewMatch.Parameters.Add(new SqlParameter("@end_time", Endtime));



            conn.Open();
            try { addNewMatch.ExecuteNonQuery(); } catch (Exception ignore) { }
            conn.Close();

            Response.Write("Added Succefully");

        }

        protected void delete_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Hostclub = hostclub.Text;
            String Guestclub = guestclub.Text;


            SqlCommand deleteMatch = new SqlCommand("deleteMatch", conn);
            deleteMatch.CommandType = CommandType.StoredProcedure;
            deleteMatch.Parameters.Add(new SqlParameter("@host_club_name", Hostclub));
            deleteMatch.Parameters.Add(new SqlParameter("@guest_club_name", Guestclub));




            conn.Open();
            try { deleteMatch.ExecuteNonQuery(); } catch (Exception ignore) { }
            conn.Close();

            Response.Write("Delete Succefully");

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {

                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter("Select*From allMatches", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                test.InnerHtml +="Host Club:"+" ";
                Div1.InnerHtml +="Guest Club:"+" ";
                Div2.InnerHtml +="Start Time:"+" ";
                Div3.InnerHtml +="End Time:"+" ";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    
                    string str = dt.Rows[i][0].ToString();
                    test.InnerHtml +=str.ToString()+" ";
                    string str2 = dt.Rows[i][1].ToString();
                    Div1.InnerHtml += str2.ToString()+" ";
                    string str3 = dt.Rows[i][2].ToString();
                    Div2.InnerHtml += str3.ToString()+" ";
                    string str4 = dt.Rows[i][3].ToString();
                    Div3.InnerHtml += str4.ToString()+" ";
                    

                }
            }

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {

                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT* From [dbo].matchesRankedByAttendance()", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                Div8.InnerHtml +="Host Club:"+" ";
                Div5.InnerHtml +="Guest Club:"+" ";
                Div6.InnerHtml +="Start Time:"+" ";
                Div7.InnerHtml +="End Time:"+" ";
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    string str = dt.Rows[i][0].ToString();
                    Div8.InnerHtml +=str.ToString()+" ";
                    string str2 = dt.Rows[i][1].ToString();
                    Div5.InnerHtml += str2.ToString()+" ";
                    string str3 = dt.Rows[i][2].ToString();
                    Div6.InnerHtml += str3.ToString()+" ";
                    string str4 = dt.Rows[i][3].ToString();
                    Div7.InnerHtml += str4.ToString()+" ";


                }
            }

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {

                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT* From clubsNeverMatched", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                Div9.InnerHtml +="First Club:"+" ";
                Div10.InnerHtml +="Second Club:"+" ";
               
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string str = dt.Rows[i][0].ToString();
                    Div8.InnerHtml +=str.ToString()+" ";
                    string str2 = dt.Rows[i][1].ToString();
                    Div5.InnerHtml += str2.ToString()+" ";
                }
            }
        }
    }
}
