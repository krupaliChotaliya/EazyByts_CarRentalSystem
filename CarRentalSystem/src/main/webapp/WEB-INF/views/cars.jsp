<%@ page import="com.car.rental.system.Model.Car" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head data-pg-collapsed>
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>DriveEase</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
    />

    <style>
        .collapse {
            visibility: inherit !important;
        }

        .poster {
            z-index: 0;
        }

        .poster:before {
            background-image: url(https://i.pinimg.com/originals/b9/20/dd/b920dd46cc3fb6ddf119346d9f94bbb4.jpg) !important;
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
            content: ' ';
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            position: absolute;
        }

        body.poster:before {
            position: fixed;
        }

        @media (min-width: 1440px), (min-width: 992px) and (-webkit-min-device-pixel-ratio: 2), (min-width: 992px) and (min-resolution: 192dpi) {
            .poster:before {
                background-image:  url(https://i.pinimg.com/originals/b9/20/dd/b920dd46cc3fb6ddf119346d9f94bbb4.jpg) !important;     }
        }
    </style>

    <script>
        (function () {
            try {
                if (!document.documentElement.hasAttribute("data-pg-ia-disabled")) {
                    window.pgia_small_mq =
                        typeof pgia_small_mq == "string"
                            ? pgia_small_mq
                            : "(max-width:767px)";
                    window.pgia_large_mq =
                        typeof pgia_large_mq == "string"
                            ? pgia_large_mq
                            : "(min-width:768px)";
                    var style = document.createElement("style");
                    var pgcss =
                        'html:not(.pg-ia-no-preview) [data-pg-ia-hide=""] {opacity:0;visibility:hidden;}html:not(.pg-ia-no-preview) [data-pg-ia-show=""] {opacity:1;visibility:visible;display:block;}';
                    if (
                        document.documentElement.hasAttribute("data-pg-id") &&
                        document.documentElement.hasAttribute("data-pg-mobile")
                    ) {
                        pgia_small_mq = "(min-width:0)";
                        pgia_large_mq = "(min-width:99999px)";
                    }
                    pgcss +=
                        "@media " +
                        pgia_small_mq +
                        '{ html:not(.pg-ia-no-preview) [data-pg-ia-hide="mobile"] {opacity:0;visibility:hidden;}html:not(.pg-ia-no-preview) [data-pg-ia-show="mobile"] {opacity:1;visibility:visible;display:block;}}';
                    pgcss +=
                        "@media " +
                        pgia_large_mq +
                        '{html:not(.pg-ia-no-preview) [data-pg-ia-hide="desktop"] {opacity:0;visibility:hidden;}html:not(.pg-ia-no-preview) [data-pg-ia-show="desktop"] {opacity:1;visibility:visible;display:block;}}';
                    style.innerHTML = pgcss;
                    document.querySelector("head").appendChild(style);
                }
            } catch (e) {
                console && console.log(e);
            }
        })();
    </script>
</head>
<body class="font-serif text-gray-500">
<header class="bg-gray-900 bg-opacity-95 py-2">
    <div class="container mx-auto relative">
        <nav class="navbar navbar-expand-lg bg-transparent navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="/">DriveEase</a>
                <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="/cars">Cars</a>
                        </li>
                        <% String userId = null;
                            HttpSession httpSession = (HttpSession)
                                    request.getSession(false);
                            if (httpSession != null &&
                                    httpSession.getAttribute("userId") != null) {
                                userId = httpSession.getAttribute("userId").toString();
                            }
                            if (userId != null) {
                        %>

                        <li class="nav-item">
                            <a class="nav-link active" href="/logout">Logout</a>
                        </li>
                        <% } %>
                        <% String authenticated = null;
                            HttpSession httpSession1 = (HttpSession)
                                    request.getSession(false);
                            if (httpSession1 != null &&
                                    httpSession1.getAttribute("userId") != null) {
                                authenticated = httpSession1.getAttribute("userId").toString();
                            }
                            if
                            (authenticated == null) { %>

                        <li class="nav-item">
                            <a class="nav-link active" href="/login">login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="/register">Register</a>
                        </li>
                        <% } %>
                        <% String role = null;
                            if (httpSession != null &&
                                    httpSession.getAttribute("role") != null) {
                                role = httpSession.getAttribute("role").toString();
                            }
                            if (role != null
                                    && role.equals("admin")) { %>

                        <li class="nav-item">
                            <a class="nav-link active" href="/dashboard/users">Admin DashBoard</a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</header>
<main>
    <section class="bg-secondary-500 poster relative text-gray-300">
        <div class="container mx-auto pb-24 pt-72 px-4">
            <div class="-mx-4 flex flex-wrap items-center space-y-6 lg:space-y-0">
                <div class="px-4 w-full md:w-9/12 xl:w-7/12 2xl:w-6/12">
                    <p class="font-bold font-sans mb-1 text-2xl text-white">
                        DriveEase
                    </p>
                    <h1
                            class="font-bold mb-6 text-5xl text-white md:leading-tight lg:leading-tight lg:text-6xl"
                    >
                        For Your
                        <span class="text-primary-500">Everyday Commute</span> or
                        <span class="text-primary-500">Leisure</span>
                    </h1>
                    <div class="bg-white p-6">
                        <h2 class="font-bold mb-2 text-gray-900 text-xl">
                            Let&apos;s find your ideal car
                        </h2>
                        <form>
                            <div class="-mx-2 flex flex-wrap items-center">
                                <div class="p-1 w-full sm:flex-1">
                                    <input
                                            class="appearance-none border px-5 py-2 text-gray-600 w-full"
                                            type="email"
                                            required
                                            placeholder="Enter your pick up location..."
                                    />
                                </div>
                                <div class="p-1 w-full sm:w-4/12">
                                    <input
                                            class="appearance-none border px-5 py-2 text-gray-600 w-full"
                                            type="date"
                                            required
                                    />
                                </div>
                                <div
                                        class="p-1 text-right w-full sm:flex-initial sm:w-auto"
                                >
                                    <a
                                            href="#"
                                            class="bg-primary-500 hover:bg-primary-600 inline-block px-6 py-2 text-center text-white"
                                    ><span>Search</span></a
                                    >
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="bg-gray-50 py-24">
        <div class="container mx-auto px-4">
            <div class="-mx-4 flex flex-wrap items-center mb-6">
                <div class="px-4 w-full md:w-10/12">
                    <h2 class="font-medium mb-1 text-primary-500 text-xl">
                        Our Top Cars
                    </h2>
                    <h3 class="capitalize font-bold mb-4 text-4xl text-gray-900">
                        Cars for all your needs
                    </h3>
                    <div class="bg-primary-500 mb-6 pb-1 w-2/12"></div>
                </div>
            </div>
            <div class="-mx-3 flex flex-wrap justify-center mb-12">
                <% List<Car> cars = (List<Car>) request.getAttribute("cars");
                    if (cars != null) {
                        for (Car car : cars) { %>

                <div class="p-3 w-full md:w-6/12 lg:w-4/12">
                    <div class="bg-white border shadow-md text-gray-500">
                        <img src="${pageContext.request.contextPath}/image/<%= car.getImage() %>" alt="Image">
                        <div class="p-6">
                            <h4 class="font-bold mb-2 text-gray-900 text-xl">
                                <a href="#" class="hover:text-gray-500"
                                >    <%= car.getBrand() %></a
                                >
                            </h4>
                            <p class="mb-2 text-sm">
                                <%= car.getModel() %>
                            </p>
                            <hr class="border-gray-200 my-4"/>
                            <div class="flex items-center justify-between">
                                <div class="inline-flex items-center py-1 space-x-1">
                                    <a href="/cars/car/<%= car.getId() %>">
                                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                            Book now
                                        </button>
                                    </a>
                                </div>
                                <p class="font-bold text-gray-900">$<%= car.getPrice_per_day() %>/day</p>
                            </div>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>
    </section>
</main>
<footer class="bg-black bg-opacity-90 pt-12 text-gray-300">
    <div class="container mx-auto px-4 relative">
        <div class="flex flex-wrap -mx-4">
            <div class="p-4 w-full lg:w-4/12">
                <a
                        href="#"
                        class="font-bold font-sans hover:text-opacity-90 inline-flex items-center leading-none mb-4 space-x-2 text-3xl text-primary-500 uppercase"
                >
                    <svg
                            version="1.0"
                            xmlns="http://www.w3.org/2000/svg"
                            width="3em"
                            xml:space="preserve"
                            fill="currentColor"
                            viewBox="0 0 100 100"
                            height="3em"
                    >
                <path
                        d="M38.333 80a11.571 11.571 0 0 1-7.646-2.883A11.724 11.724 0 0 1 26.834 70H10V46.667L43.333 40l20-20H90v26.667H43.995l-27.328 5.465v11.2h11.166a11.787 11.787 0 0 1 4.212-4.807 11.563 11.563 0 0 1 12.577 0 11.789 11.789 0 0 1 4.213 4.807h7.833V70h-6.837a11.719 11.719 0 0 1-3.853 7.117A11.571 11.571 0 0 1 38.333 80Zm0-16.667a5 5 0 1 0 5 5 5.006 5.006 0 0 0-5.001-5Zm27.761-36.666L52.762 40h30.571V26.667Z"
                ></path>
                        <path
                                d="M56.667 63.333h-7.833a11.6 11.6 0 0 0-21 0H16.667v-11.2l27.328-5.465h12.672Z"
                                opacity="0.2"
                        ></path>
                        <path
                                d="M90 63.333H80v-10h-6.667v10h-10V70h10v10H80V70h10Z"
                        ></path>
                        <path
                                d="M52.762 40h30.571V26.667H66.094Z"
                                opacity="0.2"
                        ></path></svg
                    >
                    <span>Prime Drive</span>
                </a>
                <ul class="mb-4 space-y-1">
                    <li>9056 Fairground Ave., New York, USA</li>
                    <li>
                        <a href="#" class="hover:text-gray-400 text-white"
                        >+0 123 456 7890</a
                        >
                    </li>
                    <li>
                        <a
                                href="mailto:hello@fafo.com"
                                class="hover:text-gray-400 text-white"
                        >info@company.com</a
                        >
                    </li>
                </ul>
                <div class="flex-wrap inline-flex space-x-3">
                    <a href="#" aria-label="facebook" class="hover:text-gray-400">
                        <svg viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                            <path
                                    d="M14 13.5h2.5l1-4H14v-2c0-1.03 0-2 2-2h1.5V2.14c-.326-.043-1.557-.14-2.857-.14C11.928 2 10 3.657 10 6.7v2.8H7v4h3V22h4v-8.5z"
                            />
                        </svg
                        >
                    </a>
                    <a href="#" aria-label="twitter" class="hover:text-gray-400">
                        <svg viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                            <path
                                    d="M22.162 5.656a8.384 8.384 0 0 1-2.402.658A4.196 4.196 0 0 0 21.6 4c-.82.488-1.719.83-2.656 1.015a4.182 4.182 0 0 0-7.126 3.814 11.874 11.874 0 0 1-8.62-4.37 4.168 4.168 0 0 0-.566 2.103c0 1.45.738 2.731 1.86 3.481a4.168 4.168 0 0 1-1.894-.523v.052a4.185 4.185 0 0 0 3.355 4.101 4.21 4.21 0 0 1-1.89.072A4.185 4.185 0 0 0 7.97 16.65a8.394 8.394 0 0 1-6.191 1.732 11.83 11.83 0 0 0 6.41 1.88c7.693 0 11.9-6.373 11.9-11.9 0-.18-.005-.362-.013-.54a8.496 8.496 0 0 0 2.087-2.165z"
                            />
                        </svg
                        >
                    </a>
                    <a href="#" aria-label="instagram" class="hover:text-gray-400">
                        <svg viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                            <path
                                    d="M12 2c2.717 0 3.056.01 4.122.06 1.065.05 1.79.217 2.428.465.66.254 1.216.598 1.772 1.153a4.908 4.908 0 0 1 1.153 1.772c.247.637.415 1.363.465 2.428.047 1.066.06 1.405.06 4.122 0 2.717-.01 3.056-.06 4.122-.05 1.065-.218 1.79-.465 2.428a4.883 4.883 0 0 1-1.153 1.772 4.915 4.915 0 0 1-1.772 1.153c-.637.247-1.363.415-2.428.465-1.066.047-1.405.06-4.122.06-2.717 0-3.056-.01-4.122-.06-1.065-.05-1.79-.218-2.428-.465a4.89 4.89 0 0 1-1.772-1.153 4.904 4.904 0 0 1-1.153-1.772c-.248-.637-.415-1.363-.465-2.428C2.013 15.056 2 14.717 2 12c0-2.717.01-3.056.06-4.122.05-1.066.217-1.79.465-2.428a4.88 4.88 0 0 1 1.153-1.772A4.897 4.897 0 0 1 5.45 2.525c.638-.248 1.362-.415 2.428-.465C8.944 2.013 9.283 2 12 2zm0 5a5 5 0 1 0 0 10 5 5 0 0 0 0-10zm6.5-.25a1.25 1.25 0 0 0-2.5 0 1.25 1.25 0 0 0 2.5 0zM12 9a3 3 0 1 1 0 6 3 3 0 0 1 0-6z"
                            />
                        </svg
                        >
                    </a>
                    <a href="#" aria-label="linkedin" class="hover:text-gray-400">
                        <svg viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                            <path
                                    d="M6.94 5a2 2 0 1 1-4-.002 2 2 0 0 1 4 .002zM7 8.48H3V21h4V8.48zm6.32 0H9.34V21h3.94v-6.57c0-3.66 4.77-4 4.77 0V21H22v-7.93c0-6.17-7.06-5.94-8.72-2.91l.04-1.68z"
                            />
                        </svg
                        >
                    </a>
                    <a href="#" aria-label="youtube" class="hover:text-gray-400">
                        <svg viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                            <path
                                    d="M21.543 6.498C22 8.28 22 12 22 12s0 3.72-.457 5.502c-.254.985-.997 1.76-1.938 2.022C17.896 20 12 20 12 20s-5.893 0-7.605-.476c-.945-.266-1.687-1.04-1.938-2.022C2 15.72 2 12 2 12s0-3.72.457-5.502c.254-.985.997-1.76 1.938-2.022C6.107 4 12 4 12 4s5.896 0 7.605.476c.945.266 1.687 1.04 1.938 2.022zM10 15.5l6-3.5-6-3.5v7z"
                            />
                        </svg
                        >
                    </a>
                </div>
            </div>
            <div class="p-4 w-full sm:w-6/12 md:flex-1 lg:w-3/12">
                <h2 class="font-bold text-color3-500 text-xl">Company</h2>
                <hr class="border-gray-600 inline-block mb-6 mt-4 w-3/12"/>
                <ul>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">FAQ</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">News</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Careers</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">About Us</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Contact Us</a>
                    </li>
                </ul>
            </div>
            <div class="p-4 w-full sm:w-6/12 md:flex-1 lg:w-3/12">
                <h2 class="font-bold text-color3-500 text-xl">Vehicles</h2>
                <hr class="border-gray-600 inline-block mb-6 mt-4 w-3/12"/>
                <ul>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">SUVs</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Sedans</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Mini Vans</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Sports Cars</a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="hover:text-gray-400">Convertibles</a>
                    </li>
                </ul>
            </div>
            <div class="p-4 w-full md:w-5/12 lg:w-4/12">
                <h2 class="font-bold text-color3-500 text-xl">Top Cities</h2>
                <hr class="border-gray-600 inline-block mb-6 mt-4 w-3/12"/>
                <div class="-mx-4 flex flex-wrap">
                    <div class="pb-4 px-4 w-full sm:w-6/12">
                        <ul>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Taxes</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Boston</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Colorado</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">California</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Manhattan</a>
                            </li>
                        </ul>
                    </div>
                    <div class="pb-4 px-4 w-full sm:w-6/12">
                        <ul>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Dallas</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Huston</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Seattle</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Denver</a>
                            </li>
                            <li class="mb-4">
                                <a href="#" class="hover:text-gray-400">Phoenix</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="py-4">
            <hr class="mb-4 opacity-25"/>
            <div class="flex flex-wrap -mx-4 items-center">
                <div class="px-4 py-2 w-full md:flex-1">
                    <p>&copy; 2002 - 2021. All Rights Reserved - Company Name</p>
                </div>
                <div class="px-4 py-2 w-full md:w-auto">
                    <a href="#" class="hover:text-gray-400">Privacy Policy</a> |
                    <a href="#" class="hover:text-gray-400">Terms of Use</a>
                </div>
            </div>
        </div>
    </div>
</footer>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script src="https://cdn.tailwindcss.com"></script>

</body>
</html>
