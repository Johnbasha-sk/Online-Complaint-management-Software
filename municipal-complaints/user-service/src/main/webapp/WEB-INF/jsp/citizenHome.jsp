<%@ include file="includes/header.jsp" %>
<h3>Citizen Dashboard</h3>
<div class="row g-3">
  <div class="col-md-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">File a Complaint</h5>
        <p class="card-text">Quickly file a new complaint regarding Water, Sanitation, or Roads.</p>
        <a href="#" class="btn btn-primary">Start</a>
      </div>
    </div>
  </div>
  <div class="col-md-8">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">My Recent Complaints</h5>
        <div id="myComplaints">Loading...</div>
      </div>
    </div>
  </div>
</div>
<script>
  // Placeholder: fetch from /api/complaints/mine via Gateway when available
  document.getElementById('myComplaints').innerText = 'No complaints to show yet.';
</script>
<%@ include file="includes/footer.jsp" %>