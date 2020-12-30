<script>
	import { csv } from 'd3-fetch';	
	
	import LineChartCovid from './LineChartCovid.svelte';	

	let lineChartData;
	
	csv('fr_daily.csv').then(data => lineChartData = data);

</script>

<h2>Daily confirmed Covid Cases Freiburg</h2>

<main>	
	{#if lineChartData}
		<div class='chart'>			
			<LineChartCovid data={lineChartData} />
			<p>Source&nbsp;: covid19germany R package</p>
		</div>
	{/if}
	
</main>

<style>
	h2 {
		font: 2.5rem 'Alata', sans-serif;
		text-align: center;
		margin: 1rem 0;
	}

	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		max-width: 48rem;
		margin: 0 auto;
	}

	.chart {
		width: 100%;
		position: relative;
		margin-bottom: 1rem;
	}

	.chart h3 {
		position: absolute;
		width: 100%;
		top: 0;
		left: 50%;
		transform: translateX(-50%);
		margin: 0;
		font-size: 1.1rem;
		text-align: center;
		z-index: 42;
	}

	.chart p {
		position: absolute;
		width: 100%;
		bottom: 0;
		right: 0;
		margin: 0;
		font-size: 0.9rem;
		font-style: italic;
		text-align: right;
		z-index: 42;
	}
</style>
