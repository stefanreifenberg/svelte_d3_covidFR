<script>
	import { csv } from 'd3-fetch';	
	
	import LineChartCovid from './LineChartCovid.svelte';	

	let lineChartData;
	
	csv('fr_daily.csv').then(data => lineChartData = data);

</script>

<h1>Covid-19 development in Freiburg im Breisgau</h1>
<h2>Showing daily confirmed <span style="color:#6930c3">ill</span>, <span style="color:#02c39a">recovered</span> and <span style="color:#e56b6f">dead</span> cases</h2>

<main>	
	{#if lineChartData}
		<div class='chart'>			
			<LineChartCovid data={lineChartData} />
			<p class="author">Author: <a href="https://twitter.com/Reyfenberg">Stefan Reifenberg</a></p>
			<p class="data_source">Data source: <a href="https://github.com/nevrome/covid19germany">https://github.com/nevrome/covid19germany</a></p>
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
		display: flex;
  		justify-content: center;
		position: relative;
		height: 600px;
		width: 1000px;
	}
	.data_source {
		position: absolute;
		
		bottom: 0;
		right: 0;
		margin: 0;
		font-size: 0.9rem;
		
		text-align: right;
		
	}
	.author {
		position: absolute;
		
		bottom: 0;
		left: 0;
		margin: 0;
		font-size: 0.9rem;
	
		text-align: right;
	
	}
</style>
