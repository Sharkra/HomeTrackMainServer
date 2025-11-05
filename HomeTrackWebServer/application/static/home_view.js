const ChartView = {
  renderChartControls(chartKey, chartInstance) {
    const container = document.getElementById(`controls${chartKey.slice(-1)}`);
    container.innerHTML = '';

    chartInstance.data.datasets.forEach((dataset, index) => {
      const button = document.createElement('button');
      button.textContent = `Toggle ${dataset.label}`;
      button.onclick = () => ChartViewModel.toggleDataset(chartKey, index);
      container.appendChild(button);
    });
  }
};