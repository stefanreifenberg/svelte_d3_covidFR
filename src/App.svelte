<script>
	import { csv } from 'd3-fetch';	
	
	import LineChartCovid from './LineChartCovid.svelte';	

	let lineChartData;
	
	csv('fr_daily.csv').then(data => lineChartData = data);

</script>

<h1>Covid-19 development in Freiburg im Breisgau</h1>
<h2>Showing confirmed <span style="color:#6930c3">ill</span>, <span style="color:#02c39a">recovered</span> and <span style="color:#e56b6f">dead</span> cases</h2>

<main>	
	{#if lineChartData}
		<div class='chart'>			
			<LineChartCovid data={lineChartData} />
			<p>Data source: <a href="https://github.com/nevrome/covid19germany">https://github.com/nevrome/covid19germany</a></p>
		</div>
	{/if}
	
</main>

<style>
	h1 {
		font: 2.5rem 'Alata', sans-serif;
		text-align: center;
		margin: 1rem 0;
	}
	h2 {
		font: 2rem 'Alata', sans-serif;
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
