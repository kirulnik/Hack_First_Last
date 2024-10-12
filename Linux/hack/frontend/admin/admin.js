document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Предотвращаем отправку формы

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (username === 'admin' && password === 'Superman99') {
        alert('flag = {T1_ogus0k_aNe_Superm4n}');
        window.location.href = "/test_fastapi/nginx-1.27.1/admin/hotel/adminPanel.html";
    } else {
        document.getElementById('message').innerText = 'Неверный логин или пароль';
    }
});