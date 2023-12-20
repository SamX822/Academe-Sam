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
    public partial class RegistrationForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand comd;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            String email = txt_email.Text;
            String pass = txt_pass.Text;

            if (string.IsNullOrWhiteSpace(txt_name.Text) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pass) || string.IsNullOrWhiteSpace(txt_passConfirm.Text) || string.IsNullOrWhiteSpace(txt_address.Text))
            {
                lbl_Status.Text = "Please input all fields";
                return;
            }

            if (txt_passConfirm.Text.Equals(pass))
            {

                string query1 = "SELECT COUNT(*) FROM Customer WHERE C_email = @C_email AND C_pass = @C_pass";
                string query2 = "SELECT COUNT(*) FROM Customer WHERE C_email = @C_email";
                string query3 = "SELECT COUNT(*) FROM Customer WHERE C_pass = @C_pass";

                using (SqlCommand cmd = new SqlCommand(query2, con))
                {
                    cmd.Parameters.AddWithValue("@C_email", email);
                    //cmd.Parameters.AddWithValue("@C_pass", pass);

                    con.Open();

                    int count = (int)cmd.ExecuteScalar();

                    if (count > 0)
                    {
                        lbl_Status.Text = "This email already exists.";
                    }
                    else if (count < 1)
                    {
                        con.Close();
                        using (SqlCommand camd = new SqlCommand(query3, con))
                        {
                            //camd.Parameters.AddWithValue("@C_email", email);
                            camd.Parameters.AddWithValue("@C_pass", pass);

                            con.Open();

                            int cnt = (int)camd.ExecuteScalar();

                            if (cnt > 0)
                            {
                                lbl_Status.Text = "This password is already taken.";
                            }
                            else if (cnt < 1)
                            {
                                con.Close();
                                using (SqlCommand cemd = new SqlCommand(query1, con))
                                {
                                    cemd.Parameters.AddWithValue("@C_email", email);
                                    cemd.Parameters.AddWithValue("@C_pass", pass);

                                    con.Open();

                                    int cont = (int)cemd.ExecuteScalar();

                                    if (cont > 0)
                                    {
                                        lbl_Status.Text = "This account already exists.";
                                    }
                                    else if (cont < 1)
                                    {
                                        comd = new SqlCommand("InsertCustomer");
                                        comd.CommandType = CommandType.StoredProcedure;
                                        comd.Parameters.AddWithValue("@C_name", txt_name.Text.Trim());
                                        comd.Parameters.AddWithValue("@C_email", txt_email.Text.Trim());
                                        comd.Parameters.AddWithValue("@C_address", txt_address.Text.Trim());
                                        comd.Parameters.AddWithValue("@C_pass", txt_pass.Text.Trim());
                                        comd.Connection = con;
                                        comd.ExecuteNonQuery();
                                        con.Close();

                                        Response.Redirect("LoginForm.aspx");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                lbl_Status.Text = "Passwords do not match.";
            }
        }
    }
}