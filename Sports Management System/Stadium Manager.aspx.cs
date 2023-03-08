using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class Stadium_Manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String query = @"SELECT S.id AS 'Stadium ID', S.name AS 'Stadium Name', S.location, S.capacity, S.status
                             FROM Stadium_Manager SM INNER JOIN Stadium S
                             ON SM.ID = S.stadium_manager_ID
                             WHERE SM.Username = @Username";

            String query2 = @"SELECT CR.name AS 'Sending Club Reprisentative Name', C1.name AS 'Host Club Name', C2.name AS 'Guest Club Name', M.start_time, M.end_time, HR.status
                              FROM Host_Request HR INNER JOIN Match M
                              ON HR.Match_ID = M.ID
                              INNER JOIN Club_Representative CR
                              ON HR.club_rep_ID = CR.ID
                              INNER JOIN Stadium_Manager SM
                              ON HR.stadium_manager_ID = SM.ID
                              INNER JOIN Club C1
                              ON M.host_club_ID = C1.ID AND C1.club_rep_ID = CR.ID
                              INNER JOIN Club C2
                              ON M.guest_club_ID = C2.ID
                              WHERE SM.Username = @Username";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Parameters.Add(new SqlParameter("@Username", Session["Username"].ToString()));

            SqlCommand cmd2 = new SqlCommand(query2, conn);
            cmd2.CommandType = System.Data.CommandType.Text;
            cmd2.Parameters.Add(new SqlParameter("@Username", Session["Username"].ToString()));

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            StadiumManagerStadium.DataSource = reader;
            StadiumManagerStadium.DataBind();
            reader.Close();
            SqlDataReader reader1 = cmd2.ExecuteReader();
            allRequestsForManager.DataSource = reader1;
            allRequestsForManager.DataBind();
            reader1.Close();
            conn.Close();
        }

        protected void Accept_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String StadiumManagerUsername = Session["Username"].ToString();
            String Host_Club_Name = HostClubName.Text;
            String Guest_Club_Name = GuestClubName.Text;
            String Match_Start_Time = MatchStartTime.Text;

            SqlCommand acceptRequest = new SqlCommand("acceptRequest", conn);
            acceptRequest.CommandType = System.Data.CommandType.StoredProcedure;
            acceptRequest.Parameters.Add(new SqlParameter("@stadium_manager_username", StadiumManagerUsername));
            acceptRequest.Parameters.Add(new SqlParameter("@hostingclubname", Host_Club_Name));
            acceptRequest.Parameters.Add(new SqlParameter("@guestclubname", Guest_Club_Name));
            acceptRequest.Parameters.Add(new SqlParameter("@starttime", DateTime.Parse(Match_Start_Time)));

            conn.Open();
            acceptRequest.ExecuteNonQuery();
            Response.Redirect("Stadium Manager.aspx");
            conn.Close();
        }

        protected void Reject_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String StadiumManagerUsername = Session["Username"].ToString();
            String Host_Club_Name = HostClubName.Text;
            String Guest_Club_Name = GuestClubName.Text;
            String Match_Start_Time = MatchStartTime.Text;

            SqlCommand rejectRequest = new SqlCommand("rejectRequest", conn);
            rejectRequest.CommandType = System.Data.CommandType.StoredProcedure;
            rejectRequest.Parameters.Add(new SqlParameter("@stadium_manager_username", StadiumManagerUsername));
            rejectRequest.Parameters.Add(new SqlParameter("@host_club_name", Host_Club_Name));
            rejectRequest.Parameters.Add(new SqlParameter("@guest_club_name", Guest_Club_Name));
            rejectRequest.Parameters.Add(new SqlParameter("@match_start_time", DateTime.Parse(Match_Start_Time)));

            conn.Open();
            rejectRequest.ExecuteNonQuery();
            Response.Redirect("Stadium Manager.aspx");
            conn.Close();
        }
    }
}