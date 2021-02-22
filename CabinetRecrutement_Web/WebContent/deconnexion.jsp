<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%if(session.getAttribute("utilisateur") == null){
%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations : </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
		<br><br>
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         Vous êtes déjà déconnecté
                         <ul>
                           <li>Si vous voulez vous connectez : <a href="template.jsp?action=connexion">login in</a></li>
                         </ul>
                         <br>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
<%
}
if(session.getAttribute("utilisateur") != null){
	session.setAttribute("utilisateur", null); %>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Deconnexion </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        
		<br><br>
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         Vous avez bien été déconnecté
                         <ul>
                           <li>Pour vous reconnectez : <a href="template.jsp?action=connexion">login in</a></li>
                         </ul>
                         <br>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->