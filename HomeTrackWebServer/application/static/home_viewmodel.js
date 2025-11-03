import * as ChartJS from "./external_packages/package/dist/chart.umd.js"

function createLineChart(ctxId, datasets, buttonIds, options = {}) {
  const ctx = document.getElementById(ctxId).getContext('2d');
  const chart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: options.labels || [],
      datasets,
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { labels: { color: '#333' } },
      },
      scales: {
        x: { ticks: { color: '#333' } },
        y: { beginAtZero: true, ticks: { color: '#333' } },
      },
    },
  });

  // Attach toggle handlers
  buttonIds.forEach((btnId, index) => {
    const btn = document.getElementById(btnId);
    btn.addEventListener('click', () => {
      const ds = chart.data.datasets[index];
      ds.hidden = !ds.hidden;
      btn.classList.toggle('hidden', ds.hidden);
      chart.update();
    });
  });

  return chart;
}
// ===== Chart 1 =====
createLineChart(
  'chart1',
  [
    {
      label: 'Sales ($)',
      data: [120, 150, 180, 220, 170, 200, 250],
      borderColor: '#2563eb',
      backgroundColor: 'rgba(37,99,235,0.2)',
      tension: 0.3,
      fill: true,
    },
    {
      label: 'Revenue ($)',
      data: [80, 130, 160, 210, 150, 190, 230],
      borderColor: '#16a34a',
      backgroundColor: 'rgba(22,163,74,0.2)',
      tension: 0.3,
      fill: true,
    },
  ],
  ['toggle1a', 'toggle1b'],
  { labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'] }
);

// ===== Chart 2 =====
createLineChart(
  'chart2',
  [
    {
      label: 'Visitors',
      data: [300, 400, 350, 500, 450, 600, 550],
      borderColor: '#dc2626',
      backgroundColor: 'rgba(220,38,38,0.2)',
      tension: 0.3,
      fill: true,
    },
    {
      label: 'Signups',
      data: [50, 60, 55, 80, 70, 90, 85],
      borderColor: '#9333ea',
      backgroundColor: 'rgba(147,51,234,0.2)',
      tension: 0.3,
      fill: true,
    },
  ],
  ['toggle2a', 'toggle2b'],
  { labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'] }
  );