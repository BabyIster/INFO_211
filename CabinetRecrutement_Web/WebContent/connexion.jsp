<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String identifiantUser = request.getParameter("identifiantUser");

if(identifiantUser == null && session.getAttribute("utilisateur") == null){%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Connectez-vous : </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
        
		  <form action="template.jsp?action=connexion" method="post">
		  <div class="form-group">
		    <label for="identifiantUser">Votre identifiant :</label>
		    <input type="text" class="form-control" name="identifiantUser" placeholder="Identifiant">
		  </div>
		  <button type="submit" class="btn btn-lg btn-success btn-block">Se connecter</button>
		</form>
		<br><br>
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         L'identifiant est la clé primaire préfixée de :
                         <ul>
                           <li>pour une entreprise : <code>ENT_</code> <em>(ENT_12 par exemple)</em></li>
                           <li>pour une candidature : <code>CAND_</code> <em>(CAND_7 par exemple)</em></li>
                         </ul>
                         <br>
                         <em>Note : l'identification se fait sans mot de passe.</em>
                       </div>
        </div> <!-- /.table-responsive -->
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->

<%}if(session.getAttribute("utilisateur") != null){
%>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations : </h3></div> <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="dataTable_wrapper">
		<br><br>
		<div class="alert alert-info col-xs-offset-3 col-xs-6">
                         Vous êtes déjà connecté <%=identifiantUser %>
                         <ul>
                           <li>Si vous voulez vous deconnectez : <a href="template.jsp?action=deconnexion">login out</a></li>
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
if(identifiantUser != null){
session.setAttribute("utilisateur", identifiantUser); 
%>

<%
}%>