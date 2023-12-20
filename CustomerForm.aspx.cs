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
    public partial class CustomerForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack){
                reload();
            }
        }
        void reload()
        {
            con.Open();
            cmd = new SqlCommand("CustomerView");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "CustomerView");
            //GridView1.DataSource = ds.Tables[0];
            //GridView1.DataBind();
            con.Close();
        }

        void refresh()
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_toItemsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("ItemsForm.aspx");
        }

        protected void btn_insert_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("InsertCustomer");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@C_name", txt_name.Text.Trim());
            cmd.Parameters.AddWithValue("@C_email", txt_email.Text.Trim());
            cmd.Parameters.AddWithValue("@C_address", txt_address.Text.Trim());
            cmd.Parameters.AddWithValue("@C_pass", txt_pass.Text.Trim());
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();

            //reload();
            refresh();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected row
            GridViewRow row = GridView1.SelectedRow;

            // Update the EditCommand and DeleteCommand with the selected C_id
            MonteDB.UpdateCommand = "UPDATE Customer SET C_name=@C_name, C_email=@C_email, C_address=@C_address, C_pass=@C_pass WHERE (C_id = @C_id)";
            MonteDB.DeleteCommand = "UPDATE Customer SET C_delete=1 WHERE (C_id=@C_id)";

            // Set the parameters for the UpdateCommand and DeleteCommand
            MonteDB.UpdateParameters.Add("C_id", DbType.Int32, row.Cells[0].Text);
            MonteDB.DeleteParameters.Add("C_id", DbType.Int32, row.Cells[0].Text);

            // Rebind the GridView with the updated commands
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchBar = txtSearch.Text;
            var existingParameter = MonteDB.SelectParameters["searchName"];

            if (!String.IsNullOrEmpty(txtSearch.Text))
            {
                if (existingParameter != null)
                {
                    MonteDB.SelectParameters.Remove(existingParameter);
                }

                MonteDB.SelectParameters.Add("searchName", "%" + searchBar + "%");

                MonteDB.SelectCommand = "SELECT C_id, C_name, C_email, C_address, C_pass FROM [Customer] WHERE ([C_delete] = @C_delete) AND ([C_name] LIKE @searchName)";

            }
            else
            {
                // Reset the EditCommand and DeleteCommand when performing a search
                MonteDB.UpdateCommand = "UPDATE Customer SET C_name=@C_name, C_email=@C_email, C_address=@C_address, C_pass=@C_pass WHERE (C_id=@C_id)";
                MonteDB.DeleteCommand = "UPDATE Customer SET C_delete=1 WHERE (C_id=@C_id)";


                refresh();
            }
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void btn_toAdminsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminForm.aspx");
        }

        protected void btn_toAdminOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminOrders.aspx");
        }
    }
}