using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String query = @"CREATE PROCEDURE UserLogin 
                                @Username VARCHAR(20),
	                            @Password VARCHAR(20),
	                            @Output INT OUTPUT
                                AS
                                    IF EXISTS(
                                        SELECT SU.Username, SU.Password
                                        FROM SystemUser SU INNER JOIN System_Admin SA
                                        ON SA.Username = SU.Username
                                        WHERE SU.Username = @Username AND SU.Password = @Password
                                        )
                                    BEGIN
                                        SELECT @Output = 1
                                    END
                                    ELSE BEGIN
                                        IF EXISTS(
                                        SELECT SU.Username, SU.Password
                                        FROM SystemUser SU INNER JOIN Stadium_Manager SM
                                        ON SM.Username = SU.Username
                                        WHERE SU.Username = @Username AND SU.Password = @Password
                                        )
                                        BEGIN
                                            SELECT @Output = 2
                                        END
                                        ELSE BEGIN
                                            IF EXISTS(
                                            SELECT SU.Username, SU.Password
                                            FROM SystemUser SU INNER JOIN Sport_Association_Manager SAM
                                            ON SAM.Username = SU.Username
                                            WHERE SU.Username = @Username AND SU.Password = @Password
                                            )
                                            BEGIN
                                                SELECT @Output = 3
                                            END
                                            ELSE BEGIN
                                                IF EXISTS(
                                                SELECT SU.Username, SU.Password
                                                FROM SystemUser SU INNER JOIN Club_Representative CR
                                                ON CR.Username = SU.Username
                                                WHERE SU.Username = @Username AND SU.Password = @Password
                                                )
                                                BEGIN
                                                    SELECT @Output = 4
                                                END
                                                ELSE BEGIN
                                                    IF EXISTS(
                                                    SELECT SU.Username, SU.Password
                                                    FROM SystemUser SU INNER JOIN Fan F
                                                    ON F.Username = SU.Username
                                                    WHERE SU.Username = @Username AND SU.Password = @Password AND F.status = 1
                                                    )
                                                    BEGIN
                                                        SELECT @Output = 5
                                                    END
                                                    ELSE BEGIN
                                                        SELECT @Output = 0
                                                    END
                                                END
                                            END
                                        END
                                    END; ";

            SqlCommand log = new SqlCommand(query, conn);

            conn.Open();
            try { log.ExecuteNonQuery(); } catch (Exception) { }
            conn.Close();
        }
        protected void username_TextChanged(object sender, EventArgs e)
        {

        }
        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["Milestone2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String Username = username.Text;
            String Password = password.Text;
            String query2 = @"CREATE PROCEDURE CheckIfClubExists
	                            @ClubName VARCHAR(20),
	                            @Output INT OUTPUT
	                            AS
		                            IF NOT EXISTS(
			                            SELECT name, location
			                            FROM Club
			                            WHERE name = @ClubName
		                            )
		                            BEGIN
			                            SELECT @Output = 1
		                            END
		                            ELSE BEGIN
			                            SELECT @Output = 0
		                            END;";
            String query3 = @"CREATE PROCEDURE CheckIfStadiumExists
	                            @StadiumName VARCHAR(20),
	                            @Output INT OUTPUT
	                            AS
		                            IF NOT EXISTS(
			                            SELECT name, location
			                            FROM Stadium
			                            WHERE name = @StadiumName
		                            )
		                            BEGIN
			                            SELECT @Output = 1
		                            END
		                            ELSE BEGIN
			                            SELECT @Output = 0
		                            END;";

            SqlCommand createClubCheckersProc = new SqlCommand(query2, conn);
            SqlCommand createStadiumCheckersProc = new SqlCommand(query3, conn);

            SqlCommand loginproc = new SqlCommand("UserLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@Username", Username));
            loginproc.Parameters.Add(new SqlParameter("@Password", Password));

            SqlParameter Output = loginproc.Parameters.Add("@Output", SqlDbType.Int);
            Output.Direction = ParameterDirection.Output;

            Session["Username"] = Username;

            conn.Open();
            try { createClubCheckersProc.ExecuteNonQuery(); } catch (Exception) { }
            try { createStadiumCheckersProc.ExecuteNonQuery(); } catch (Exception) { }
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (Output.Value.ToString() == "1")
            {
                Response.Redirect("System Admin.aspx");
            }else if (Output.Value.ToString() == "2")
            {
                Response.Redirect("Stadium Manager.aspx");
            }
            else if (Output.Value.ToString() == "3")
            {
                Response.Redirect("Sport Association Manager.aspx");
            }
            else if (Output.Value.ToString() == "4")
            {
                Response.Redirect("Club Representative.aspx");
            }
            else if (Output.Value.ToString() == "5")
            {
                Session["Fan National ID"] = "1A2B";
                Response.Redirect("Fan.aspx");
            }
            else
            {
                Response.Write("Incorrect Username Or Password Or User may be blocked");
            }
        }

        protected void Register1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}