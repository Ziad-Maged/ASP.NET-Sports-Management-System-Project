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
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void View_Upcoming_Matches_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            DateTime specifiedTime = DateTime.Parse(Date_Time.Text);
            String Query = @"SELECT * FROM [dbo].availableMatchesToAttend(@date);";

            SqlCommand cmd = new SqlCommand(Query, conn);
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Parameters.AddWithValue("@date", specifiedTime);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            Matches.DataSource = reader;
            Matches.DataBind();
            reader.Close();
            conn.Close();
        }

        protected void Purchase_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Query = @"EXECUTE purchaseTicket @national_ID_fan, @host_club_name, @guest_club_name, @start_time;";

            String Host_Club_Name = HostClubName.Text;
            String Guest_Club_Name = GuestClubName.Text;
            String Start_Time_Of_Match = MatchStartTime.Text;

            SqlCommand purchaseTicket = new SqlCommand("purchaseTicket", conn);
            purchaseTicket.CommandType = System.Data.CommandType.StoredProcedure;
            purchaseTicket.Parameters.Add(new SqlParameter("@national_ID_fan", Session["Fan National ID"].ToString()));
            purchaseTicket.Parameters.Add(new SqlParameter("@host_club_name", Host_Club_Name));
            purchaseTicket.Parameters.Add(new SqlParameter("@guest_club_name", Guest_Club_Name));
            purchaseTicket.Parameters.Add(new SqlParameter("@start_time", DateTime.Parse(Start_Time_Of_Match)));

            conn.Open();
            purchaseTicket.ExecuteNonQuery();
            Response.Write("TEST");
            conn.Close();
        }
    }
}