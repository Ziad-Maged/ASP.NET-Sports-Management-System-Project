using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Name = name.Text;
            String Username = username.Text;
            String Password = password.Text;

            String Name0 = name0.Text;
            String Username0 = username0.Text;
            String Password0 = password0.Text;

            String Name1 = name1.Text;
            String Username1 = username1.Text;
            String Password1 = password1.Text;

            String Name2 = name2.Text;
            String Username2 = username2.Text;
            String Password2 = password2.Text;

            String clubname = Clubname.Text;
            String stadiumname = Stadiumname.Text;
            String NationalId = nationalidnumber.Text;
            String Dateofbirth = dateofbirth.Text;
            String adress = Adress.Text;
            String Phonenmber = Phonenumber.Text;
            
            SqlCommand addRepresentative = new SqlCommand("addRepresentative", conn);
            addRepresentative.CommandType = CommandType.StoredProcedure;
            addRepresentative.Parameters.Add(new SqlParameter("@Name", Name));
            addRepresentative.Parameters.Add(new SqlParameter("@ClubName", clubname));
            addRepresentative.Parameters.Add(new SqlParameter("@Username", Username));
            addRepresentative.Parameters.Add(new SqlParameter("@Password", Password));

            SqlCommand addStadiumManager = new SqlCommand("addStadiumManager", conn);
            addStadiumManager.CommandType = CommandType.StoredProcedure;
            addStadiumManager.Parameters.Add(new SqlParameter("@Name", Name0));
            addStadiumManager.Parameters.Add(new SqlParameter("@stadium_name", stadiumname));
            addStadiumManager.Parameters.Add(new SqlParameter("@Username", Username0));
            addStadiumManager.Parameters.Add(new SqlParameter("@Password", Password0));

            SqlCommand addFan = new SqlCommand("addFan", conn);
            addFan.CommandType = CommandType.StoredProcedure;
            addFan.Parameters.Add(new SqlParameter("@Name", Name1));
            addFan.Parameters.Add(new SqlParameter("@Username", Username1));
            addFan.Parameters.Add(new SqlParameter("@Password", Password1));
            addFan.Parameters.Add(new SqlParameter("@natIDno", NationalId));
            addFan.Parameters.Add(new SqlParameter("@adress", adress));
            addFan.Parameters.Add(new SqlParameter("@phoneno", Phonenmber));

            
            SqlCommand addAssociationManager = new SqlCommand("addAssociationManager", conn);
            addAssociationManager.CommandType = CommandType.StoredProcedure;
            addAssociationManager.Parameters.Add(new SqlParameter("@name", Name2));
            addAssociationManager.Parameters.Add(new SqlParameter("@user_name", Username2));
            addAssociationManager.Parameters.Add(new SqlParameter("@password", Password2));

            conn.Open();
            try { addRepresentative.ExecuteNonQuery(); } catch (Exception) { Response.Write("Username Alread Exists"); }
            try { addFan.ExecuteNonQuery(); } catch (Exception) { Response.Write("Username Alread Exists"); }
            try { addStadiumManager.ExecuteNonQuery(); } catch (Exception) { Response.Write("Username Alread Exists"); }
            try { addAssociationManager.ExecuteNonQuery(); } catch (Exception) { Response.Write("Username Alread Exists"); }
            conn.Close();

            Response.Write("Added Succefully");
        }

        protected void ClubRepresentive_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void username0_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void username1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}