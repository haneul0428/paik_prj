
    $(function () {
    // 차트 객체들을 저장할 변수
    let salesChart, totalChart, memberChart, vocChart;
        // 기준 요일 배열 (일요일이 0, 월요일이 1, ... 토요일이 6)
     const weekDays = ['일', '월', '화', '수', '목', '금', '토'];
     const today = new Date();
     const labels = [];

     for (let i = 1; i < 8; i++) {
         // 현재 날짜에서 i일 전의 날짜 계산
         const pastDate = new Date(today);
         pastDate.setDate(today.getDate() - i);
         // 해당 날짜의 요일을 weekDays 배열에서 가져오기
         const dayLabel = weekDays[pastDate.getDay()];
         // labels 배열에 추가
         labels.push(dayLabel);
     }

    labels.reverse();

    // 초기 차트 설정
    function initCharts() {
    // 차트 1: 음료/디저트 판매량
    salesChart = new Chart(document.getElementById('chart1'), {
    type: 'bar',
    data: {
    labels: labels,
    datasets: [{
    label: '음료/커피 판매량',
    backgroundColor: 'rgba(50, 99, 132, 0.5)',
    data: []
}, {
    label: '디저트/아이스크림 판매량',
    backgroundColor: 'rgba(70, 190, 132, 0.5)',
    data: []
}]
},
    options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
    title: {
    display: true,
    text: '일일 판매량(건수)'
}
}
}
});

    // 차트 2: 총 매출
    totalChart = new Chart(document.getElementById('chart2'), {
    type: 'line',
    data: {
    labels: labels,
    datasets: [{
    label: '총 매출',
    borderColor: 'rgba(153, 102, 255, 1)',
    tension: 0.1,
    data: []
}]
},
    options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
    title: {
    display: true,
    text: '일일 총 매출량'
}
}
}
});

    // 차트 3: 회원 현황
    memberChart = new Chart(document.getElementById('chart3'), {
    type: 'bar',
    data: {
    labels: labels,
    datasets: [{
    label: '신규 회원 수',
    backgroundColor: 'rgba(75, 192, 192, 0.5)',
    data: []
}, {
    label: '탈퇴 회원 수',
    backgroundColor: 'rgb(255, 99, 132,0.5)',
    data: []
}]
},
    options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
    title: {
    display: true,
    text: '일일 신규 회원 및 탈퇴 회원'
}
}
}
});

    // 차트 4: VOC
    vocChart = new Chart(document.getElementById('chart4'), {
    type: 'line',
    data: {
    labels: labels,
    datasets: [{
    label: '고객의 소리',
    borderColor: 'rgba(54, 162, 235, 1)',
    tension: 0.1,
    data: []
}]
},
    options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
    title: {
    display: true,
    text: '일일 고객의 소리(건수)'
}
}
}
});
}

    initCharts();  // 차트 초기화
    loadAllData(); // 초기 데이터 로드
    setInterval(loadAllData, 60000); // 1분마다 업데이트

});

    function loadAllData() {

    $('.chart-container').addClass('loading');

    $.ajax({
    url: 'http://localhost/paik_prj/manager/dashboard/dashboardData.jsp',
    data: { type: 'sales' },
    dataType: "json",
    success:function (data) {
    updateSalesChart(data);
},
    error:function(xhr){
    console.error(xhr.status);
}
});

    $.ajax({
    url: 'http://localhost/paik_prj/manager/dashboard/dashboardData.jsp',
    data: { type: 'members' },
    dataType: "json",
    success: function (data) {
    updateMemberChart(data);
},
    error: function (xhr) {
    console.error(xhr.status);
}
});

    $.ajax({
    url: 'http://localhost/paik_prj/manager/dashboard/dashboardData.jsp',
    data: { type: 'total' },
    dataType: "json",
    success:function (data) {
    updateTotalChart(data);
},
    error: function (xhr) {
    console.error(xhr.status);
}
});

    $.ajax({
    url: 'http://localhost/paik_prj/manager/dashboard/dashboardData.jsp',
    data: { type: 'voc' },
    dataType: "json",
    success:function (data) {
    updateVocChart(data);
},
    error: function (xhr) {
    console.log(xhr.status);
}
});
}
    function updateSalesChart(data) {
    const chart = Chart.getChart("chart1");
    if (chart) {
    // 배열을 뒤집어서 최신 데이터가 오른쪽에 표시되도록 함
    chart.data.datasets[0].data = [...data.drinkSales].reverse();
    chart.data.datasets[1].data = [...data.dessertSales].reverse();
    chart.update();
}
}

    function updateMemberChart(data) {
    const chart = Chart.getChart("chart3");
    if (chart) {
    chart.data.datasets[0].data = [...data.joins].reverse();
    chart.data.datasets[1].data = [...data.withdraws].reverse();
    chart.update();
}
}

    function updateTotalChart(data) {
    const chart = Chart.getChart("chart2");
    if (chart) {
    chart.data.datasets[0].data = [...data.totals].reverse();
    chart.update();
}
}

    function updateVocChart(data) {
    const chart = Chart.getChart("chart4");
    if (chart) {
    chart.data.datasets[0].data = [...data.vocs].reverse();
    chart.update();
}
}
