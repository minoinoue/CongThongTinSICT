package Controller;

  import Dal.UserDAO;
  import Model.User;
  import java.io.IOException;
  import java.sql.SQLException;
  import java.sql.Timestamp;
  import java.text.ParseException;
  import java.text.SimpleDateFormat;
  import java.util.List;
  import javax.servlet.ServletException;
  import javax.servlet.http.HttpServlet;
  import javax.servlet.http.HttpServletRequest;
  import javax.servlet.http.HttpServletResponse;

  public class ManageUserController extends HttpServlet {

      @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
          System.out.println("ManageUserController: Handling request for " + request.getServletPath());
          String action = request.getServletPath();
          UserDAO userDAO = new UserDAO();
          try {
              if (action.equals("/manage-users")) {
                  System.out.println("ManageUserController: Fetching user list");
                  List<User> users = userDAO.getAllUsers();
                  request.setAttribute("listU", users);
                  System.out.println("ManageUserController: Forwarding to /manage-users.jsp");
                  request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
              } else if (action.equals("/manageuseredit")) {
                  System.out.println("ManageUserController: Handling manageuseredit");
                  String userId = request.getParameter("uID");
                  if (userId != null) {
                      // Optionally handle delete user functionality here
                  }
              }
          } catch (SQLException e) {
              System.err.println("ManageUserController: SQL Error - " + e.getMessage());
              request.setAttribute("error", "Error retrieving users: " + e.getMessage());
              System.out.println("ManageUserController: Forwarding to /manage-users.jsp due to error");
              request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
          } catch (Exception e) {
              System.err.println("ManageUserController: General Error - " + e.getMessage());
              request.setAttribute("error", "General error: " + e.getMessage());
              System.out.println("ManageUserController: Forwarding to /manage-users.jsp due to general error");
              request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
          } finally {
              userDAO.close();
          }
      }

      @Override
      protected void doPost(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
          UserDAO userDAO = new UserDAO();
          try {
              String action = request.getServletPath();
              if (action.equals("/manageuseredit")) {
                  // Retrieve form data
                  int userId = Integer.parseInt(request.getParameter("id"));
                  String username = request.getParameter("username");
                  String password = request.getParameter("password");
                  String fullName = request.getParameter("fullName");
                  String email = request.getParameter("email");
                  String ngayDangKyStr = request.getParameter("ngayDangKy");

                  // Validate input
                  if (username == null || username.trim().isEmpty() ||
                      password == null || password.trim().isEmpty() ||
                      fullName == null || fullName.trim().isEmpty() ||
                      email == null || email.trim().isEmpty() ||
                      ngayDangKyStr == null || ngayDangKyStr.trim().isEmpty()) {
                      request.setAttribute("error", "Please fill in all required fields.");
                      List<User> users = userDAO.getAllUsers();
                      request.setAttribute("listU", users);
                      request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
                      return;
                  }

                  // Parse date
                  Timestamp ngayDangKy = null;
                  try {
                      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                      ngayDangKy = new Timestamp(dateFormat.parse(ngayDangKyStr).getTime());
                  } catch (ParseException e) {
                      request.setAttribute("error", "Invalid date format.");
                      List<User> users = userDAO.getAllUsers();
                      request.setAttribute("listU", users);
                      request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
                      return;
                  }

                  // Create User object
                  User user = new User();
                  user.setUserID(userId);
                  user.setUsername(username);
                  user.setPasswordHash(password); // In a real application, hash the password
                  user.setFullName(fullName);
                  user.setEmail(email);
                  user.setNgayDangKy(ngayDangKy);

                  // Update user in database
                  boolean updated = userDAO.updateUser(user);
                  if (updated) {
                      response.sendRedirect("manage-users");
                  } else {
                      request.setAttribute("error", "Failed to update user.");
                      List<User> users = userDAO.getAllUsers();
                      request.setAttribute("listU", users);
                      request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
                  }
              }
          } catch (SQLException e) {
              request.setAttribute("error", "Database error: " + e.getMessage());
              List<User> users = null;
              try {
                  users = userDAO.getAllUsers();
              } catch (SQLException e1) {
                  e1.printStackTrace();
              }
              request.setAttribute("listU", users);
              request.getRequestDispatcher("/manage-users.jsp").forward(request, response);
          } finally {
              userDAO.close();
          }
      }
  }