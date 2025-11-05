const ChartViewModel = {
  charts: {},
  socket: null,

  initCharts(initialData) {
    const ctx1 = document.getElementById('chart1').getContext('2d');
    const ctx2 = document.getElementById('chart2').getContext('2d');

    this.charts.chart1 = new Chart(ctx1, {
      type: 'line',
      data: initialData.chart1,
      options: { responsive: true }
    });

    this.charts.chart2 = new Chart(ctx2, {
      type: 'bar',
      data: initialData.chart2,
      options: { responsive: true }
    });

    ChartView.renderChartControls('chart1', this.charts.chart1);
    ChartView.renderChartControls('chart2', this.charts.chart2);
  },

  updateCharts(newData) {
    ['chart1', 'chart2'].forEach((key) => {
      const chart = this.charts[key];
      chart.data.labels = newData[key].labels;
      chart.data.datasets = newData[key].datasets;
      chart.update();
      ChartView.renderChartControls(key, chart);
    });
  },

  toggleDataset(chartKey, datasetIndex) {
    const chart = this.charts[chartKey];
    const meta = chart.getDatasetMeta(datasetIndex);
    meta.hidden = meta.hidden === null ? !chart.data.datasets[datasetIndex].hidden : null;
    chart.update();
  },

  connectWebSocket() {
    this.socket = io();

    this.socket.on('chart_update', (data) => {
      console.log(data)
      if (!this.charts.chart1) {
        this.initCharts(data);
      } else {
        this.updateCharts(data);
      }
    });
  }
};

window.addEventListener('DOMContentLoaded', () => {
  ChartViewModel.connectWebSocket();
});