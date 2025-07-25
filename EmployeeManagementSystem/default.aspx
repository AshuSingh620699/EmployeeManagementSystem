<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <!-- Bootstrap CDN for responsiveness -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* General Reset */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Arial', sans-serif;
            font-weight:800;
        }

        /* Navbar Styles - Transparent */
        .navbar {
            background-color:transparent; /* Transparent navbar */
            padding: 15px;
            backdrop-filter: blur(10px); /* Adds a slight blur to the navbar background */
        }

        .navbar-brand {
            color: #333;
            font-size: 24px;
        }

        .navbar-nav .nav-link {
            color: #333 !important;
            font-size: 18px;
        }

            .navbar-nav .nav-link:hover {
                color: #333 !important;
            }

        /* Home Section Styling */
        #home {
            background: url('admin.png') no-repeat center center fixed; /* Cool background image */
            background-size: cover; /* Ensures the image covers the entire section */
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full screen height */
            text-align: center;
            flex-direction: column;
            box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.4);
        }

            #home h1 {
                font-size: 4rem;
                font-weight: bold;
                margin-bottom: 20px;
                color:#333;
                font-weight:600;
            }

            #home p {
                font-size: 1.5rem;
                margin-bottom: 30px;
                color: #333;
                font-weight: 600;
            }

        /* Buttons Styling */
        .btn-home {
            margin: 10px;
            padding: 15px 30px;
            font-size: 1.2rem;
            border-radius: 5px;
            text-transform: uppercase;
        }

        .btn-admin {
            background-color: #28a745;
            color: white;
            border: none;
        }

        .btn-employee {
            background-color: #ffc107;
            color: white;
            border: none;
        }

        .btn-home:hover {
            opacity: 0.9;
        }

        /* About Section Styling */
        #about {
            background-size: contain;
            background: url('about.jpg') no-repeat center fixed; /* Light pink to light blue gradient */
            height: 100vh; /* Full screen height */
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            flex-direction: column;
            padding: 30px;
            color: #333;
            box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.1);
        }

            #about h2 {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 20px;
            }

            #about p {
                font-size: 1.5rem;
                max-width: 800px;
                line-height: 1.6;
                margin-bottom: 20px;
            }

        /* Contact Us Section Styling */
        #contact {
            background-size: cover;
            background: url('contact.jpg') no-repeat center center fixed; /* Soft pastel pink */
            height: 100vh; /* Full screen height */
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            flex-direction: column;
            padding: 30px;
            color: #333;
            box-shadow: inset 0 0 50px rgba(0, 0, 0, 0.1);
        }

            #contact h2 {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 20px;
            }

            #contact p {
                font-size: 1.5rem;
                max-width: 800px;
                line-height: 1.6;
                margin-bottom: 20px;
            }

        /* Footer Styles */
        .footer {
            background-color: #333;
            color: white;
            padding: 10px;
            text-align: center;
            position: relative;
            width: 100%;
        }

        /* Media Queries for responsiveness */
        @media screen and (max-width: 768px) {
            #home h1 {
                font-size: 3rem;
            }

            .navbar-nav {
                text-align: center;
            }

                .navbar-nav .nav-link {
                    font-size: 16px;
                }

            .btn-home {
                font-size: 1rem;
                padding: 12px 25px;
            }

            #about h2, #contact h2 {
                font-size: 2.5rem;
            }

            #about p, #contact p {
                font-size: 1.2rem;
            }

            /* Adjust background size for mobile */
            #about, #contact {
                height: auto; /* Allow content to flow naturally on smaller screens */
            }
        }

        /* Scroll animation effect */
        #home, #about, #contact {
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Employee Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact Us</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Home Section -->
    <div id="home">
        <div>
            <h1>Welcome to Employee Management System</h1>
            <p>Manage your employees easily and efficiently</p>
            <!-- Buttons for login -->
            <div>
                <button id="btn1" class="btn-home btn-admin">Admin Login</button>
                <button id="btn2" class="btn-home btn-employee">Employee Login</button>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <div id="about">
        <h2>About Us</h2>
        <p>We provide an easy-to-use platform for managing employee data, including leaves, attendance, and more. Our goal is to streamline HR tasks and improve employee satisfaction with a modern and efficient system.</p>
        <p>Whether you're a small business or a large enterprise, our system can help you manage your workforce with ease. We focus on simplicity, security, and seamless integration.</p>
    </div>

    <!-- Contact Us Section -->
    <div id="contact">
        <h2>Contact Us</h2>
        <p>If you have any questions, feel free to reach out to us. We're always here to help!</p>
        <p>Email: support@ems.com</p>
        <p>Phone: +1 234 567 890</p>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Employee Management System</p>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('btn1').addEventListener('click', () => {
            window.location.href = "AdminLogin.aspx";
        })

        document.getElementById('btn2').addEventListener('click', () => {
            window.location.href = "EmployeeLogin.aspx";
        })
    </script>
</body>
</html>
