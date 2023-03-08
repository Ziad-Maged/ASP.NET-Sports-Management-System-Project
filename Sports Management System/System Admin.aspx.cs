using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class System_Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddClub_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = ADDClubName.Text;
            String location = ADDClubLocation.Text;
            
            SqlCommand cmd = new SqlCommand("CheckIfClubExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ClubName", name));
            SqlParameter Output = cmd.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;

            SqlCommand addClub = new SqlCommand("addClub", conn);
            addClub.CommandType = CommandType.StoredProcedure;
            addClub.Parameters.Add(new SqlParameter("@ClubName", name));
            addClub.Parameters.Add(new SqlParameter("@ClubLocation", location));

            conn.Open();
            cmd.ExecuteNonQuery();
            if(Output.Value.ToString() == "1")
            {
                addClub.ExecuteNonQuery();
                Response.Write("Adding Performed Successfully");
            }else
            {
                Response.Write("Club Already Exists");
            }
            conn.Close();
        }

        protected void DeleteClub_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = DeleteClubName.Text;

            SqlCommand cmd = new SqlCommand("CheckIfClubExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ClubName", name));
            SqlParameter Output = cmd.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;

            SqlCommand deleteClub = new SqlCommand("deleteClub", conn);
            deleteClub.CommandType = CommandType.StoredProcedure;
            deleteClub.Parameters.Add(new SqlParameter("@name", name));

            conn.Open();
            cmd.ExecuteNonQuery();
            if (Output.Value.ToString() == "0")
            {
                deleteClub.ExecuteNonQuery();
                Response.Write("Club Deleted Successfully");
            }
            else
            {
                Response.Write("Club Does Not Exist");
            }
            conn.Close();
        }

        protected void AddStadium_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = AddStadiumName.Text;
            String location = AddStadiumLocation.Text;
            int capacity = Int32.Parse(AddStadiumCapacity.Text);

            SqlCommand cmd = new SqlCommand("CheckIfStadiumExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@StadiumName", name));
            SqlParameter Output = cmd.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;

            SqlCommand addStadium = new SqlCommand("addStadium", conn);
            addStadium.CommandType = CommandType.StoredProcedure;
            addStadium.Parameters.Add(new SqlParameter("@stadium_name", name));
            addStadium.Parameters.Add(new SqlParameter("@location", location));
            addStadium.Parameters.Add(new SqlParameter("@capacity", capacity));

            conn.Open();
            cmd.ExecuteNonQuery();
            if (Output.Value.ToString() == "1")
            {
                addStadium.ExecuteNonQuery();
                Response.Write("Adding Performed Successfully");
            }
            else
            {
                Response.Write("Stadium Already Exists");
            }
            conn.Close();
        }

        protected void DeleteStadium_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = DeleteStadiumName.Text;

            SqlCommand cmd = new SqlCommand("CheckIfStadiumExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@StadiumName", name));
            SqlParameter Output = cmd.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;

            SqlCommand deleteStadium = new SqlCommand("deleteStadium", conn);
            deleteStadium.CommandType = CommandType.StoredProcedure;
            deleteStadium.Parameters.Add(new SqlParameter("@stadium_name", name));

            conn.Open();
            cmd.ExecuteNonQuery();
            if (Output.Value.ToString() == "0")
            {
                deleteStadium.ExecuteNonQuery();
                Response.Write("Stadium Deleted Successfully");
            }
            else
            {
                Response.Write("Stadium Does Not Exists");
            }
            conn.Close();
        }

        protected void BlockFan_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String fanNationalID = BlockFanID.Text;

            SqlCommand blockFan = new SqlCommand("blockFan", conn);
            blockFan.CommandType = CommandType.StoredProcedure;
            blockFan.Parameters.Add(new SqlParameter("@national_id_fan", fanNationalID));

            conn.Open();
            blockFan.ExecuteNonQuery();
            Response.Write("Fan Blocked Successfully");
            conn.Close();
        }

        protected void UnblockFam_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String fanNationalID = BlockFanID.Text;

            SqlCommand unblockFan = new SqlCommand("unblockFan", conn);
            unblockFan.CommandType = CommandType.StoredProcedure;
            unblockFan.Parameters.Add(new SqlParameter("@national_id_fan", fanNationalID));

            conn.Open();
            unblockFan.ExecuteNonQuery();
            Response.Write("Fan Unblocked Successfully");
            conn.Close();
        }
    }
}