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
    public partial class Sport_Association_Manager : System.Web.UI.Page
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
            try { addNewMatch.ExecuteNonQuery(); } catch (Exception) { }
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
            try { deleteMatch.ExecuteNonQuery(); } catch (Exception) { }
            conn.Close();

            Response.Write("Delete Succefully");

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Query = @"SELECT C1.name AS 'Host Club Name', C2.name 'Guest Club Name', M.start_time AS 'Start Time', M.end_time AS 'End Time'
		                    FROM Match M INNER join Club C1
		                    ON M.host_club_ID = C1.ID
		                    INNER JOIN Club C2
		                    ON M.guest_club_ID = C2.ID
		                    INNER JOIN Stadium S
		                    ON M.host_stadium_ID = S.ID
		                    WHERE M.start_time > CURRENT_TIMESTAMP";

            SqlCommand cmd = new SqlCommand(Query, conn);
            cmd.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            allMatchesView.DataSource = reader;
            allMatchesView.DataBind();
            reader.Close();
            conn.Close();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Query = @"SELECT * FROM [dbo].matchesRankedByAttendance()";

            SqlCommand cmd = new SqlCommand(Query, conn);
            cmd.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            AlreadyPlayedMatches.DataSource = reader;
            AlreadyPlayedMatches.DataBind();
            reader.Close();
            conn.Close();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Query = @"SELECT DISTINCT C.name AS 'First club name', C1.name AS 'Second club name'
		                    FROM Club C, Club C1
		                    WHERE C.ID <> C1.ID AND
		                    NOT EXISTS(
			                    SELECT DISTINCT C2.name AS 'First club name', C3.name AS 'Second club name'
			                    FROM Club C2, Club C3, Match M
			                    WHERE M.host_club_ID = C2.ID AND
			                    M.guest_club_ID = C3.ID AND
			                    C2.ID <> C3.ID AND ((C.ID = C2.ID AND C3.ID = C1.ID) OR (C.ID = C3.ID AND C1.ID = C2.ID))
		                    )";

            SqlCommand cmd = new SqlCommand(Query, conn);
            cmd.CommandType = CommandType.Text;

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            ClubsNeverMatched.DataSource = reader;
            ClubsNeverMatched.DataBind();
            reader.Close();
            conn.Close();
            /*String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {

                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * From clubsNeverMatched", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                Div9.InnerHtml += "First Club:" + " ";
                Div10.InnerHtml += "Second Club:" + " ";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string str = dt.Rows[i][0].ToString();
                    Div8.InnerHtml += str.ToString() + " ";
                    string str2 = dt.Rows[i][1].ToString();
                    Div5.InnerHtml += str2.ToString() + " ";
                }
            }*/
        }
    }
}
