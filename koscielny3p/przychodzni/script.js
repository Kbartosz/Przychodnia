document.getElementById('show-register').addEventListener('click', function (e) {
    e.preventDefault();
    document.querySelector('.login-container').classList.add('hidden');
    document.querySelector('.register-container').classList.remove('hidden');
});

document.getElementById('show-login').addEventListener('click', function (e) {
    e.preventDefault();
    document.querySelector('.register-container').classList.add('hidden');
    document.querySelector('.login-container').classList.remove('hidden');
});
