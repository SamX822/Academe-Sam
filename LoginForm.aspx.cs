using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class LoginForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void refresh()
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            String email = txt_email.Text;
            String pass = txt_pass.Text;
            String secure = txt_secure.Text;

            string queryAd = "SELECT COUNT(*) FROM Admin WHERE a_userID = @a_userID AND a_pass = @a_pass";
            using (SqlCommand adm = new SqlCommand(queryAd, con))
            {
                adm.Parameters.AddWithValue("@a_userID", email);
                adm.Parameters.AddWithValue("@a_pass", pass);

                con.Open();

                int count = (int)adm.ExecuteScalar();

                if (count > 0)
                {
                    con.Close();

                    string query1 = "SELECT COUNT(*) FROM Admin WHERE a_userID = @a_userID AND a_pass = @a_pass AND a_secure = @a_secure";
                    using (SqlCommand admi = new SqlCommand(query1, con))
                    {
                        admi.Parameters.AddWithValue("@a_userID", email);
                        admi.Parameters.AddWithValue("@a_pass", pass);
                        admi.Parameters.AddWithValue("@a_secure", secure);

                        con.Open();

                        int cot = (int)admi.ExecuteScalar();

                        if (txt_secure.Text.Equals(""))
                        {
                            lbl_Status.Text = "Please enter the security code.";
                            con.Close();
                            txt_secure.Visible = true;
                            Label9.Visible = true;
                        }
                        else if (cot > 0)
                        {
                            con.Close();

                            SqlCommand logout;
                            con.Open();
                            logout = new SqlCommand("ClearLogin");
                            logout.CommandType = CommandType.StoredProcedure;
                            logout.Connection = con;
                            logout.ExecuteNonQuery();
                            con.Close();

                            SqlCommand comd;
                            con.Open();
                            comd = new SqlCommand("InsertLogin");
                            comd.CommandType = CommandType.StoredProcedure;
                            comd.Parameters.AddWithValue("@log_email", txt_email.Text.Trim());
                            comd.Parameters.AddWithValue("@log_pass", txt_pass.Text.Trim());
                            comd.Connection = con;
                            comd.ExecuteNonQuery();
                            con.Close();

                            Response.Redirect("CustomerForm.aspx");
                        }
                        else
                        {
                            con.Close();
                            txt_secure.Visible = false;
                            Label9.Visible = false;
                            //refresh();
                            lbl_Status.Text = "Invalid credentials. Please try again.";
                            return;
                        }
                    }
                }
                else
                {
                    con.Close();
                    string query = "SELECT COUNT(*) FROM Customer WHERE C_email = @C_email AND C_pass = @C_pass";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@C_email", email);
                        cmd.Parameters.AddWithValue("@C_pass", pass);

                        con.Open();

                        int cnt = (int)cmd.ExecuteScalar();

                        if (cnt > 0)
                        {
                            con.Close();

                            SqlCommand log;
                            con.Open();
                            log = new SqlCommand("ClearLogin");
                            log.CommandType = CommandType.StoredProcedure;
                            log.Connection = con;
                            log.ExecuteNonQuery();
                            con.Close();

                            SqlCommand camd;
                            con.Open();
                            camd = new SqlCommand("InsertLogin");
                            camd.CommandType = CommandType.StoredProcedure;
                            camd.Parameters.AddWithValue("@log_email", txt_email.Text.Trim());
                            camd.Parameters.AddWithValue("@log_pass", txt_pass.Text.Trim());
                            camd.Connection = con;
                            camd.ExecuteNonQuery();
                            con.Close();

                            Response.Redirect("BookStoreForm.aspx");
                        }
                        else
                        {
                            lbl_Status.Text = "Invalid credentials. Please try again.";
                            con.Close();
                        }
                    }
                }
            }
        }

        protected void btn_create_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrationForm.aspx");
        }
    }
}