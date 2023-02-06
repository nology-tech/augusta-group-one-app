const Score = require('../models/score.model');

const getScores = async (req, res, next) => {
	try {
		const scores = await Score.find();

		res
			.status(200)
			.send({ scores });
	} catch (err) {
		console.log(err);
		next();
	}
};

const addScore = async (req, res, next) => {
	try {
		if (!req.body.data.name || !req.body.data.score) {
			throw new Error('missing required fields');
		}

		let newScore = {
			name: req.body.data.name,
			score: req.body.data.score,
		};

		const savedScore = await Score.create(newScore);

		res
			.status(201)
			.send({ score: savedScore });
	} catch (err) {
		if (err.message) {
			res.status(400).send({ message: err.message });
		} else {
			res.status(500).send({ message: 'server error' });
		}
	}
};

module.exports = {
	getScores,
	addScore,
};
