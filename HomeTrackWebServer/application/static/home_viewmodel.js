// Set the default options of charts.
// If not the one desired for a specific chart, change it on the dataset
Chart.defaults.elements.line.tension= 0.2
Chart.defaults.elements.line.responsive=true

const ChartViewModel = {
  charts: {},

  async initCharts() {
    const response = await fetch('/api/all-current-data');
    const current_data = await response.json();

    console.log(current_data)

    power_data={
      type: 'line',
      data: current_data,
      options: {
        responsive: true
      }
    }

    const ctx1 = document.getElementById('power_chart').getContext('2d');
    this.charts.power_chart = new Chart(ctx1, power_data);
    ChartView.renderChartControls('power_chart', this.charts.power_chart);
    
    const ctx2 = document.getElementById('chart2').getContext('2d');
    this.charts.chart2 = new Chart(ctx2, power_data);
    ChartView.renderChartControls('chart2', this.charts.power_chart);
  },

  toggleDataset(chartKey, datasetIndex) {
    const chart = this.charts[chartKey];
    const meta = chart.getDatasetMeta(datasetIndex);
    meta.hidden = meta.hidden === null ? !chart.data.datasets[datasetIndex].hidden : null;
    chart.update();
  },

  addDataset(chartKey, newDataset) {
    const chart = this.charts[chartKey];
    chart.data.datasets.push(newDataset);
    chart.update();
    ChartView.renderChartControls(chartKey, chart);
  },

  removeDataset(chartKey, datasetIndex) {
    const chart = this.charts[chartKey];
    chart.data.datasets.splice(datasetIndex, 1);
    chart.update();
    ChartView.renderChartControls(chartKey, chart);
  }
};

const ChartView = {
  renderChartControls(chartKey, chartInstance) {
    const container = document.getElementById(`${chartKey}_controls`);
    container.innerHTML = '';

    chartInstance.data.datasets.forEach((dataset, index) => {
      const button = document.createElement('button');
      button.textContent = `Toggle ${dataset.label}`;
      button.onclick = () => ChartViewModel.toggleDataset(chartKey, index);
      container.appendChild(button);
    });
  }
};

window.addEventListener('DOMContentLoaded', () => {
  ChartViewModel.initCharts();
});