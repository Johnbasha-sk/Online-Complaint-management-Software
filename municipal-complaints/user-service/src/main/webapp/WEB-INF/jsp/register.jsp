<%@ include file="includes/header.jsp" %>
<div class="row justify-content-center">
  <div class="col-md-6 col-lg-5">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title mb-3">Register</h5>
        <form id="registerForm">
          <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" class="form-control" id="username" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" class="form-control" id="name" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" id="email" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" id="password" required />
          </div>
          <button type="submit" class="btn btn-success w-100">Create account</button>
        </form>
        <div class="mt-3 text-center">
          <a href="/ui/login">Already have an account? Login</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  document.getElementById('registerForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const body = { username: username.value, name: name.value, email: email.value, password: password.value };
    const res = await fetch('/api/auth/register', {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body)
    });
    if (res.ok) {
      alert('Registration successful. Please login.');
      location.href = '/ui/login';
    } else {
      const data = await res.json();
      alert('Registration failed: ' + (data.error || JSON.stringify(data.errors)) );
    }
  });
</script>
<%@ include file="includes/footer.jsp" %>