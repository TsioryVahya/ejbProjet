<!-- Sidebar Template for Modern Banking System -->
<!-- This template contains the common sidebar structure to be used across all JSP files -->

<!-- Sidebar -->
<div class="hidden md:flex md:w-64 md:flex-col">
    <div class="flex flex-col flex-grow pt-5 overflow-y-auto bg-gradient-to-b from-bank-blue to-blue-800 shadow-xl">
        <!-- Logo -->
        <div class="flex items-center flex-shrink-0 px-6 py-4">
            <div class="flex items-center">
                <div class="flex-shrink-0">
                    <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                        <i class="fas fa-university text-bank-blue text-xl"></i>
                    </div>
                </div>
                <div class="ml-3">
                    <h1 class="text-white text-lg font-bold">BankSystem</h1>
                    <p class="text-blue-200 text-xs">Gestion Bancaire</p>
                </div>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="mt-8 flex-1 px-3 space-y-1">
            <a href="${pageContext.request.contextPath}/accueil" 
               class="[ACTIVE_HOME] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-home text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Tableau de Bord</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/client/list" 
               class="[ACTIVE_CLIENTS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-users text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Clients</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/compte/list" 
               class="[ACTIVE_COMPTES] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-credit-card text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Comptes</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/operations/list" 
               class="[ACTIVE_OPERATIONS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-exchange-alt text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Opérations</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/epargne/list" 
               class="[ACTIVE_EPARGNE] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-piggy-bank text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Épargne</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/pret/list" 
               class="[ACTIVE_PRETS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-3 py-3 text-sm font-medium rounded-lg transition-all duration-200">
                <i class="fas fa-hand-holding-usd text-blue-300 mr-3 text-lg group-hover:text-blue-200"></i>
                <span>Prêts</span>
            </a>
        </nav>

        <!-- Footer Sidebar -->
        <div class="flex-shrink-0 p-4 border-t border-blue-600">
            <div class="text-center">
                <p class="text-xs text-blue-200">© 2025 BankSystem</p>
                <p class="text-xs text-blue-300 mt-1">v2.0.0</p>
            </div>
        </div>
    </div>
</div>

<!-- Mobile menu button -->
<div class="md:hidden">
    <button id="mobile-menu-button" class="fixed top-4 left-4 z-50 bg-bank-blue text-white p-2 rounded-lg shadow-lg">
        <i class="fas fa-bars"></i>
    </button>
</div>

<!-- Mobile sidebar -->
<div id="mobile-sidebar" class="fixed inset-0 z-40 md:hidden hidden">
    <div class="fixed inset-0 bg-gray-600 bg-opacity-75" onclick="toggleMobileSidebar()"></div>
    <div class="relative flex-1 flex flex-col max-w-xs w-full bg-gradient-to-b from-bank-blue to-blue-800">
        <div class="absolute top-0 right-0 -mr-12 pt-2">
            <button onclick="toggleMobileSidebar()" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
                <i class="fas fa-times text-white"></i>
            </button>
        </div>
        <div class="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
            <div class="flex-shrink-0 flex items-center px-4">
                <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center">
                    <i class="fas fa-university text-bank-blue"></i>
                </div>
                <h1 class="ml-2 text-white text-lg font-bold">BankSystem</h1>
            </div>
            <nav class="mt-5 px-2 space-y-1">
                <a href="${pageContext.request.contextPath}/accueil" class="[MOBILE_ACTIVE_HOME] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-home mr-3"></i>Tableau de Bord
                </a>
                <a href="${pageContext.request.contextPath}/client/list" class="[MOBILE_ACTIVE_CLIENTS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-users mr-3"></i>Clients
                </a>
                <a href="${pageContext.request.contextPath}/compte/list" class="[MOBILE_ACTIVE_COMPTES] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-credit-card mr-3"></i>Comptes
                </a>
                <a href="${pageContext.request.contextPath}/operations/list" class="[MOBILE_ACTIVE_OPERATIONS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-exchange-alt mr-3"></i>Opérations
                </a>
                <a href="${pageContext.request.contextPath}/epargne/list" class="[MOBILE_ACTIVE_EPARGNE] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-piggy-bank mr-3"></i>Épargne
                </a>
                <a href="${pageContext.request.contextPath}/pret/list" class="[MOBILE_ACTIVE_PRETS] text-blue-100 hover:bg-blue-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md">
                    <i class="fas fa-hand-holding-usd mr-3"></i>Prêts
                </a>
            </nav>
        </div>
    </div>
</div>

<!-- Mobile sidebar script -->
<script>
    // Mobile sidebar functionality
    function toggleMobileSidebar() {
        const sidebar = document.getElementById('mobile-sidebar');
        sidebar.classList.toggle('hidden');
    }

    // Mobile menu button functionality
    document.getElementById('mobile-menu-button').addEventListener('click', toggleMobileSidebar);

    // Close mobile sidebar when clicking outside
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('mobile-sidebar');
        const menuButton = document.getElementById('mobile-menu-button');
        
        if (!sidebar.contains(event.target) && !menuButton.contains(event.target)) {
            sidebar.classList.add('hidden');
        }
    });
</script>
