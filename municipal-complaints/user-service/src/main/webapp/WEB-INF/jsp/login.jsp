<%@ include file="includes/header.jsp" %>
<div class="row justify-content-center">
  <div class="col-md-6 col-lg-4">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title mb-3">Login</h5>
        <form id="loginForm">
          <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" class="form-control" id="username" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" id="password" required />
          </div>
          <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="mt-3 text-center">
          <a href="/ui/register">Create an account</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const res = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: username.value, password: password.value })
    });
    if (res.ok) {
      const data = await res.json();
      const role = data.user.role;
      if (role === 'ROLE_ADMIN') location.href = '/admin/home';
      else if (role === 'ROLE_STAFF') location.href = '/staff/home';
      else location.href = '/citizen/home';
    } else {
      alert('Invalid credentials');
    }
  });
</script>
<%@ include file="includes/footer.jsp" %>