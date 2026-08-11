import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js/auto"

export default class extends Controller {
  static targets = ["canvas"]
  static values = { labels: Array, prices: Array, rates: Array }

  connect() {
    new Chart(this.canvasTarget, {
      type: "line",
      data: {
        labels: this.labelsValue,
        datasets: [
          {
            label: "積みゲー総額",
            data: this.pricesValue,
            borderColor: "#325C80",
            backgroundColor: "#325C80",
            yAxisID: "y",
            spanGaps: true
          },
          {
            label: "積み率(%)",
            data: this.ratesValue,
            borderColor: "#D6D9DC",
            backgroundColor: "#D6D9DC",
            yAxisID: "y1",
            spanGaps: true
          }
        ]
      },
      options: {
        color: "#fff",
        plugins: {
          legend: {
            labels: { color: "#fff" }
          }
        },
        scales: {
          x: {
            ticks: { color: "#fff" },
            grid: { color: "rgba(255, 255, 255, 0.2)" }
          },
          y: {
            type: "linear",
            position: "left",
            ticks: { color: "#fff" },
            grid: { color: "rgba(255, 255, 255, 0.2)" }
          },
          y1: {
            type: "linear",
            position: "right",
            ticks: { color: "#fff" },
            grid: { drawOnChartArea: false }
          }
        }
      }
    })
  }
}
