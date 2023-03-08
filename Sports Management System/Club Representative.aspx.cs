using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Milestone_3
{
    public partial class Club_Representative : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write("Hello, "+ "<b>"+Session["Username"]+"</b>");
            Response.Write("<br>");
            Response.Write("<br>");
            Response.Write("<b> Club Representative </b> <hr> <br>"); 
            Response.Write("<div><b>Club Information: </b><hr> <br> </div> ");

            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("UsernameToID", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"]));
            SqlParameter Output = cmd.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;
            


            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            SqlCommand cmd2 = new SqlCommand("SELECT * FROM dbo.ClubInfo(@club_rep_id)", conn);
            // cmd.CommandType=CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@club_rep_id", Output.Value.ToString()+"");
            SqlDataAdapter da = new SqlDataAdapter(cmd2);
            DataTable dt = new DataTable();
            da.Fill(dt);

            string str = dt.Rows[0][0].ToString();
            Response.Write(str.ToString() + " ");
            string str2 = dt.Rows[0][1].ToString();
            Response.Write(str2.ToString() + " ");
            string str3 = dt.Rows[0][2].ToString();
            Response.Write(str3.ToString() + "");
            Response.Write("<br>");
            Response.Write("<br>");

            Response.Write("<div><b>Upcoming matches: </b><hr> <br> </div> ");

            SqlCommand cmd3 = new SqlCommand("SELECT * FROM dbo.upcomingMatchesOfClub(@ClubName)", conn);
            // cmd.CommandType=CommandType.StoredProcedure;  
            cmd3.Parameters.AddWithValue("@ClubName", str2.ToString());
            SqlDataAdapter da2 = new SqlDataAdapter(cmd3);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                String str4 = dt2.Rows[i][0].ToString();
                Response.Write(str4.ToString() + " ");
                String str5 = dt2.Rows[i][1].ToString();
                Response.Write(str5.ToString() + " ");
                String str6 = dt2.Rows[i][2].ToString();
                Response.Write(str6.ToString() + " ");
                String str7 = dt2.Rows[i][3].ToString();
                Response.Write(str7.ToString() + " ");
                //String str8 = dt2.Rows[i][4].ToString();
                //Response.Write(str8.ToString() + "");

                Response.Write("<br>");
            }
            Response.Write("<br>");
            Response.Write("<br>");

        }
        
        protected void ViewStadiums_Click(object sender, EventArgs e)
        {
            Response.Write(" <div><b>Available Stadiums: </b><hr> <br> </div> ");
            string date = Request.Form["stadium_date"];
            

            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.viewAvailableStadiumsOn(@DateTime)", conn);
            // cmd.CommandType=CommandType.StoredProcedure;  
            cmd.Parameters.AddWithValue("@DateTime", date);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = dt.Rows[i][0].ToString();
                Response.Write(str.ToString()+" ");
                string str2 = dt.Rows[i][2].ToString();
                Response.Write(str2.ToString() + " ");
                string str3 = dt.Rows[i][1].ToString();
                Response.Write(str3.ToString() + "");
                Response.Write("<br>");

            }
            Response.Write("<br>");
            Response.Write("<br>");
        }

        protected void SendHostRequest(object sender, EventArgs e)
        {
            string Club = Request.Form["Club_name"];
            string Stadium = Request.Form["Stadium_name"];
            string Datetime = Request.Form["Datetime"];

            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addHostRequest", conn);
            cmd.CommandType=CommandType.StoredProcedure;  
            cmd.Parameters.Add(new SqlParameter("@clubname",Club));
            cmd.Parameters.Add(new SqlParameter("@stadiumname", Stadium));
            cmd.Parameters.Add(new SqlParameter("@datetime", Datetime));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

        }
    }
}