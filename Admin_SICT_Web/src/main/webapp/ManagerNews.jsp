<%-- 
    Document   : ManagerNews
    Created on : May 10, 2025
    Author     : Lenovo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>News Management</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <style>
        .table img {
            max-width: 100%;
            max-height: 120px;
            object-fit: cover;
            border-radius: 4px;
        }
        table.table {
            border-collapse: separate;
            border-spacing: 0 10px;
        }
        table.table tr th, table.table tr td {
            border: none;
            padding: 16px;
            background: #ffffff;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .btn {
            border-radius: 6px;
            transition: transform 0.2s;
        }
        .btn:hover {
            transform: scale(1.05);
        }
        .table-title h2 {
            font-weight: bold;
            color: #ffffff;
        }
        .modal .modal-content {
            background: #fefefe;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .modal-header h4 {
            font-size: 1.5rem;
        }
        .modal-footer .btn {
            padding: 8px 16px;
        }
        .pagination .page-link {
            color: #007bff;
            border-radius: 50%;
            padding: 6px 12px;
        }
        .pagination .page-link:hover {
            background: #007bff;
            color: #fff;
        }
        .table-title .btn {
            transition: background-color 0.3s, color 0.3s;
        }
        .table-title .btn:hover {
            color: #fff;
            background: #0056b3;
        }
        .table-striped.table-hover tbody tr:hover {
            background: rgba(0, 123, 255, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2>Manage <b>News</b></h2>
                    </div>
                    <div class="col-sm-6">
                        <a href="#addNewsModal" class="btn btn-success" data-toggle="modal">
                            <i class="material-icons"></i> <span>Add New News</span>
                        </a>
                        <a href="login" class="btn btn-secondary">
                            <i class="material-icons"></i> <span>Log out</span>
                        </a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6" style="margin-top: 10px">
                        <input type="text" id="searchBar" class="form-control" placeholder="Search by title...">
                    </div>
                </div>
            </div>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Image</th>
                        <th>Excerpt</th>
                        <th>Content</th>
                        <th>Update Date</th>
                        <th>Views</th>
                        <th>Tags</th>
                        <th>Category ID</th>
                        <th>Subcategory ID</th>
                        <th>Classification ID</th>
                        <th>Admin ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="newsTableBody">
                    <c:if test="${empty listN}">
                        <tr>
                            <td colspan="13">No news found.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${listN}" var="o">
                        <tr>
                            <td>${o.maTinTuc}</td>
                            <td>${not empty o.tieuDeTinTuc ? o.tieuDeTinTuc : 'N/A'}</td>
                            <td><img src="${not empty o.urlAnh ? o.urlAnh : 'https://via.placeholder.com/120'}" alt="${not empty o.tieuDeTinTuc ? o.tieuDeTinTuc : 'No title'}"></td>
                            <td>${not empty o.trichDanTin ? o.trichDanTin : 'N/A'}</td>
                            <td>${not empty o.noiDungTin ? o.noiDungTin : 'N/A'}</td>
                            <td>${not empty o.ngayCapNhat ? o.ngayCapNhat : 'N/A'}</td>
                            <td>${o.soLanDoc != null ? o.soLanDoc : 0}</td>
                            <td>${not empty o.tag ? o.tag : 'N/A'}</td>
                            <td>${o.maTheLoai}</td>
                            <td>${o.maTheLoaiTin}</td>
                            <td>${o.maPhanLoaiTin}</td>
                            <td>${o.maThanhVien}</td>
                            <td>
                                <a href="#editNewsModal" class="edit" data-toggle="modal" 
                                   data-id="${o.maTinTuc}" 
                                   data-title="${not empty o.tieuDeTinTuc ? o.tieuDeTinTuc : ''}" 
                                   data-image="${not empty o.urlAnh ? o.urlAnh : ''}" 
                                   data-excerpt="${not empty o.trichDanTin ? o.trichDanTin : ''}" 
                                   data-content="${not empty o.noiDungTin ? o.noiDungTin : ''}" 
                                   data-update-date="${not empty o.ngayCapNhat ? o.ngayCapNhat : ''}" 
                                   data-views="${o.soLanDoc != null ? o.soLanDoc : 0}" 
                                   data-tags="${not empty o.tag ? o.tag : ''}" 
                                   data-category="${o.maTheLoai}" 
                                   data-subcategory="${o.maTheLoaiTin}" 
                                   data-classification="${o.maPhanLoaiTin}" 
                                   data-admin="${o.maThanhVien}">
                                    <i class="material-icons" data-toggle="tooltip" title="Edit"></i>
                                </a>
                                <a href="#deleteNewsModal" class="delete" data-toggle="modal" data-id="${o.maTinTuc}">
                                    <i class="material-icons" data-toggle="tooltip" title="Delete"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="clearfix">
                <div class="hint-text">Showing <b>${listN.size()}</b> out of <b>${totalNews}</b> entries</div>
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a href="manage?page=${currentPage - 1}" class="page-link">Previous</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a href="manage?page=${i}" class="page-link">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a href="manage?page=${currentPage + 1}" class="page-link">Next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <!-- Add Modal HTML -->
    <div id="addNewsModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="manageadd" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Add News</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <div class="form-group">
                            <label>Title</label>
                            <input name="title" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Image</label>
                            <input name="image" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Excerpt</label>
                            <textarea name="excerpt" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Content</label>
                            <textarea name="content" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Views</label>
                            <input name="views" type="number" class="form-control" value="0">
                        </div>
                        <div class="form-group">
                            <label>Tags</label>
                            <input name="tags" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Category ID (MaTheLoai)</label>
                            <input name="category" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Subcategory ID (MaTheLoaiTin)</label>
                            <input name="subcategory" type="number" class="form-control" value="0">
                        </div>
                        <div class="form-group">
                            <label>Classification ID (MaPhanLoaiTin)</label>
                            <input name="classification" type="number" class="form-control" value="0">
                        </div>
                        <div class="form-group">
                            <label>Admin ID (MaThanhVien)</label>
                            <input name="adminId" type="number" class="form-control" value="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-success" value="Add">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Modal HTML -->
    <div id="editNewsModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="manageedit" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit News</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <input type="hidden" name="id">
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" name="title" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Image</label>
                            <input type="text" name="image" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Excerpt</label>
                            <textarea name="excerpt" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Content</label>
                            <textarea name="content" class="form-control" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Views</label>
                            <input name="views" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Tags</label>
                            <input name="tags" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Category ID (MaTheLoai)</label>
                            <input name="category" type="number" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Subcategory ID (MaTheLoaiTin)</label>
                            <input name="subcategory" type="number" class="form-control" value="0">
                        </div>
                        <div class="form-group">
                            <label>Classification ID (MaPhanLoaiTin)</label>
                            <input name="classification" type="number" class="form-control" value="0">
                        </div>
                        <div class="form-group">
                            <label>Admin ID (MaThanhVien)</label>
                            <input name="adminId" type="number" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-info" value="Save">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Modal HTML -->
    <div id="deleteNewsModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="managedelete" method="get">
                    <input type="hidden" name="nID" id="deleteNewsID">
                    <div class="modal-header">
                        <h4 class="modal-title">Delete News</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this news?</p>
                        <p class="text-warning"><small>This action cannot be undone.</small></p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-danger" value="Delete">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="js/manager.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('.edit').on('click', function () {
                const id = $(this).data('id');
                const title = $(this).data('title');
                const image = $(this).data('image');
                const excerpt = $(this).data('excerpt');
                const content = $(this).data('content');
                const views = $(this).data('views');
                const tags = $(this).data('tags');
                const category = $(this).data('category');
                const subcategory = $(this).data('subcategory');
                const classification = $(this).data('classification');
                const admin = $(this).data('admin');

                $('#editNewsModal input[name="id"]').val(id);
                $('#editNewsModal input[name="title"]').val(title || '');
                $('#editNewsModal input[name="image"]').val(image || '');
                $('#editNewsModal textarea[name="excerpt"]').val(excerpt || '');
                $('#editNewsModal textarea[name="content"]').val(content || '');
                $('#editNewsModal input[name="views"]').val(views || 0);
                $('#editNewsModal input[name="tags"]').val(tags || '');
                $('#editNewsModal input[name="category"]').val(category || 0);
                $('#editNewsModal input[name="subcategory"]').val(subcategory || 0);
                $('#editNewsModal input[name="classification"]').val(classification || 0);
                $('#editNewsModal input[name="adminId"]').val(admin || 0);
            });

            $('.delete').on('click', function () {
                var newsID = $(this).data('id');
                $('#deleteNewsID').val(newsID);
            });

            $('#searchBar').on('keyup', function () {
                const value = $(this).val().toLowerCase();
                $('#newsTableBody tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
    </script>
</body>
</html>